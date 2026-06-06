import { supabaseAdmin } from '../config/supabase';
import { AppError } from '../middleware/error.middleware';

const notificationSelect = `
  *,
  actor:actor_id (id, username, full_name, avatar_url)
`;

export class NotificationService {
  async getMine(userId: string) {
    const { data, error } = await supabaseAdmin
      .from('notifications')
      .select(notificationSelect)
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .limit(50);

    if (error) {
      throw new AppError(error.message, 500);
    }

    return data ?? [];
  }

  async markRead(notificationId: string, userId: string) {
    const { data, error } = await supabaseAdmin
      .from('notifications')
      .update({ is_read: true })
      .eq('id', notificationId)
      .eq('user_id', userId)
      .select()
      .single();

    if (error || !data) {
      throw new AppError('Notification not found', 404);
    }

    return data;
  }

  async markAllRead(userId: string) {
    const { error } = await supabaseAdmin
      .from('notifications')
      .update({ is_read: true })
      .eq('user_id', userId)
      .eq('is_read', false);

    if (error) {
      throw new AppError(error.message, 400);
    }
  }
}

export const notificationService = new NotificationService();
