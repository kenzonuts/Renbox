import { supabaseAdmin } from '../config/supabase';
import { AppError } from '../middleware/error.middleware';

export class FollowService {
  async follow(followerId: string, followingId: string) {
    if (followerId === followingId) {
      throw new AppError('Cannot follow yourself', 400);
    }

    const { error } = await supabaseAdmin
      .from('follows')
      .insert({ follower_id: followerId, following_id: followingId });

    if (error) {
      if (error.code === '23505') {
        throw new AppError('Already following', 409);
      }
      throw new AppError(error.message, 400);
    }

    await this.createNotification(followingId, followerId, 'follow', 'started following you');
    return { following_id: followingId };
  }

  async unfollow(followerId: string, followingId: string) {
    const { error } = await supabaseAdmin
      .from('follows')
      .delete()
      .eq('follower_id', followerId)
      .eq('following_id', followingId);

    if (error) {
      throw new AppError(error.message, 400);
    }
  }

  async getFollowers(userId: string) {
    const { data, error } = await supabaseAdmin
      .from('follows')
      .select('*, profiles:follower_id (id, username, full_name, avatar_url)')
      .eq('following_id', userId);

    if (error) {
      throw new AppError(error.message, 500);
    }

    return data ?? [];
  }

  async getFollowing(userId: string) {
    const { data, error } = await supabaseAdmin
      .from('follows')
      .select('*, profiles:following_id (id, username, full_name, avatar_url)')
      .eq('follower_id', userId);

    if (error) {
      throw new AppError(error.message, 500);
    }

    return data ?? [];
  }

  private async createNotification(
    userId: string,
    actorId: string,
    type: string,
    message: string
  ) {
    await supabaseAdmin.from('notifications').insert({
      user_id: userId,
      actor_id: actorId,
      type,
      message,
    });
  }
}

export const followService = new FollowService();
