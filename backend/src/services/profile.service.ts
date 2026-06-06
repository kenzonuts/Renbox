import { supabaseAdmin } from '../config/supabase';
import { UpdateProfileInput } from '../validators/profile.validator';
import { AppError } from '../middleware/error.middleware';
import { uploadToStorage } from '../utils/storage';

export class ProfileService {
  async getByUsername(username: string) {
    const { data, error } = await supabaseAdmin
      .from('profiles')
      .select('*')
      .eq('username', username)
      .single();

    if (error || !data) {
      throw new AppError('Profile not found', 404);
    }

    return data;
  }

  async update(userId: string, input: UpdateProfileInput) {
    const { data, error } = await supabaseAdmin
      .from('profiles')
      .update(input)
      .eq('id', userId)
      .select()
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async uploadAvatar(userId: string, file: Express.Multer.File) {
    const ext = file.originalname.split('.').pop() ?? 'jpg';
    const path = `${userId}/avatar.${ext}`;
    const url = await uploadToStorage('avatars', path, file.buffer, file.mimetype);

    const { data, error } = await supabaseAdmin
      .from('profiles')
      .update({ avatar_url: url })
      .eq('id', userId)
      .select()
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async getStats(userId: string) {
    const [posts, checkins, wishlist, badges, followers, following] = await Promise.all([
      supabaseAdmin.from('posts').select('id', { count: 'exact', head: true }).eq('user_id', userId),
      supabaseAdmin.from('checkins').select('id', { count: 'exact', head: true }).eq('user_id', userId),
      supabaseAdmin.from('wishlists').select('id', { count: 'exact', head: true }).eq('user_id', userId),
      supabaseAdmin.from('user_badges').select('id', { count: 'exact', head: true }).eq('user_id', userId),
      supabaseAdmin.from('follows').select('id', { count: 'exact', head: true }).eq('following_id', userId),
      supabaseAdmin.from('follows').select('id', { count: 'exact', head: true }).eq('follower_id', userId),
    ]);

    return {
      posts_count: posts.count ?? 0,
      checkins_count: checkins.count ?? 0,
      wishlist_count: wishlist.count ?? 0,
      badges_count: badges.count ?? 0,
      followers_count: followers.count ?? 0,
      following_count: following.count ?? 0,
    };
  }
}

export const profileService = new ProfileService();
