import { supabaseAdmin } from '../config/supabase';
import { CreatePostInput, UpdatePostInput } from '../validators/post.validator';
import { AppError } from '../middleware/error.middleware';
import { uploadToStorage } from '../utils/storage';
import { getPaginationRange, buildPaginationMeta, PaginationQuery } from '../utils/pagination';

const postSelect = `
  *,
  profiles:user_id (id, username, full_name, avatar_url),
  locations:location_id (id, name, slug, city, province, category)
`;

export class PostService {
  async create(userId: string, input: CreatePostInput, file: Express.Multer.File) {
    const ext = file.originalname.split('.').pop() ?? 'jpg';
    const path = `${userId}/${Date.now()}.${ext}`;
    const imageUrl = await uploadToStorage('posts', path, file.buffer, file.mimetype);

    const { data, error } = await supabaseAdmin
      .from('posts')
      .insert({
        user_id: userId,
        location_id: input.location_id ?? null,
        caption: input.caption,
        image_url: imageUrl,
      })
      .select(postSelect)
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async getFeed(userId: string | undefined, pagination: PaginationQuery) {
    const { from, to } = getPaginationRange(pagination.page, pagination.limit);

    let query = supabaseAdmin
      .from('posts')
      .select(postSelect, { count: 'exact' })
      .order('created_at', { ascending: false })
      .range(from, to);

    const { data, error, count } = await query;

    if (error) {
      throw new AppError(error.message, 500);
    }

    const posts = data ?? [];
    if (userId && posts.length > 0) {
      const postIds = posts.map((p: { id: string }) => p.id);
      const [likes, saves] = await Promise.all([
        supabaseAdmin.from('post_likes').select('post_id').eq('user_id', userId).in('post_id', postIds),
        supabaseAdmin.from('saved_posts').select('post_id').eq('user_id', userId).in('post_id', postIds),
      ]);

      const likedSet = new Set(likes.data?.map((l) => l.post_id));
      const savedSet = new Set(saves.data?.map((s) => s.post_id));

      return {
        items: posts.map((p: Record<string, unknown>) => ({
          ...p,
          is_liked: likedSet.has(p.id as string),
          is_saved: savedSet.has(p.id as string),
        })),
        meta: buildPaginationMeta(pagination.page, pagination.limit, count ?? 0),
      };
    }

    return {
      items: posts.map((p: Record<string, unknown>) => ({
        ...p,
        is_liked: false,
        is_saved: false,
      })),
      meta: buildPaginationMeta(pagination.page, pagination.limit, count ?? 0),
    };
  }

  async getById(id: string, userId?: string) {
    const { data, error } = await supabaseAdmin
      .from('posts')
      .select(postSelect)
      .eq('id', id)
      .single();

    if (error || !data) {
      throw new AppError('Post not found', 404);
    }

    let is_liked = false;
    let is_saved = false;

    if (userId) {
      const [like, save] = await Promise.all([
        supabaseAdmin.from('post_likes').select('id').eq('post_id', id).eq('user_id', userId).maybeSingle(),
        supabaseAdmin.from('saved_posts').select('id').eq('post_id', id).eq('user_id', userId).maybeSingle(),
      ]);
      is_liked = !!like.data;
      is_saved = !!save.data;
    }

    return { ...data, is_liked, is_saved };
  }

  async update(postId: string, userId: string, input: UpdatePostInput) {
    const { data: post } = await supabaseAdmin.from('posts').select('user_id').eq('id', postId).single();
    if (!post || post.user_id !== userId) {
      throw new AppError('Post not found or unauthorized', 403);
    }

    const { data, error } = await supabaseAdmin
      .from('posts')
      .update(input)
      .eq('id', postId)
      .select(postSelect)
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async delete(postId: string, userId: string) {
    const { data: post } = await supabaseAdmin.from('posts').select('user_id').eq('id', postId).single();
    if (!post || post.user_id !== userId) {
      throw new AppError('Post not found or unauthorized', 403);
    }

    const { error } = await supabaseAdmin.from('posts').delete().eq('id', postId);
    if (error) {
      throw new AppError(error.message, 400);
    }
  }

  async like(postId: string, userId: string) {
    const { error } = await supabaseAdmin.from('post_likes').insert({ post_id: postId, user_id: userId });
    if (error) {
      if (error.code === '23505') {
        throw new AppError('Already liked', 409);
      }
      throw new AppError(error.message, 400);
    }
    return this.getById(postId, userId);
  }

  async unlike(postId: string, userId: string) {
    const { error } = await supabaseAdmin
      .from('post_likes')
      .delete()
      .eq('post_id', postId)
      .eq('user_id', userId);

    if (error) {
      throw new AppError(error.message, 400);
    }
    return this.getById(postId, userId);
  }

  async save(postId: string, userId: string) {
    const { error } = await supabaseAdmin.from('saved_posts').insert({ post_id: postId, user_id: userId });
    if (error) {
      if (error.code === '23505') {
        throw new AppError('Already saved', 409);
      }
      throw new AppError(error.message, 400);
    }
    return this.getById(postId, userId);
  }

  async unsave(postId: string, userId: string) {
    const { error } = await supabaseAdmin
      .from('saved_posts')
      .delete()
      .eq('post_id', postId)
      .eq('user_id', userId);

    if (error) {
      throw new AppError(error.message, 400);
    }
    return this.getById(postId, userId);
  }
}

export const postService = new PostService();
