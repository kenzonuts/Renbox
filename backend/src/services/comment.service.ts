import { supabaseAdmin } from '../config/supabase';
import { CreateCommentInput, UpdateCommentInput } from '../validators/comment.validator';
import { AppError } from '../middleware/error.middleware';

const commentSelect = `
  *,
  profiles:user_id (id, username, full_name, avatar_url)
`;

export class CommentService {
  async create(postId: string, userId: string, input: CreateCommentInput) {
    const { data, error } = await supabaseAdmin
      .from('comments')
      .insert({ post_id: postId, user_id: userId, content: input.content })
      .select(commentSelect)
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async getByPost(postId: string) {
    const { data, error } = await supabaseAdmin
      .from('comments')
      .select(commentSelect)
      .eq('post_id', postId)
      .order('created_at', { ascending: true });

    if (error) {
      throw new AppError(error.message, 500);
    }

    return data ?? [];
  }

  async update(commentId: string, userId: string, input: UpdateCommentInput) {
    const { data: comment } = await supabaseAdmin
      .from('comments')
      .select('user_id')
      .eq('id', commentId)
      .single();

    if (!comment || comment.user_id !== userId) {
      throw new AppError('Comment not found or unauthorized', 403);
    }

    const { data, error } = await supabaseAdmin
      .from('comments')
      .update({ content: input.content })
      .eq('id', commentId)
      .select(commentSelect)
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async delete(commentId: string, userId: string) {
    const { data: comment } = await supabaseAdmin
      .from('comments')
      .select('user_id')
      .eq('id', commentId)
      .single();

    if (!comment || comment.user_id !== userId) {
      throw new AppError('Comment not found or unauthorized', 403);
    }

    const { error } = await supabaseAdmin.from('comments').delete().eq('id', commentId);
    if (error) {
      throw new AppError(error.message, 400);
    }
  }
}

export const commentService = new CommentService();
