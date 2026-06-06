import { supabaseAdmin } from '../config/supabase';
import { CreateCheckinInput } from '../validators/checkin.validator';
import { AppError } from '../middleware/error.middleware';

const checkinSelect = `
  *,
  locations:location_id (id, name, slug, category, city, province, cover_image_url),
  profiles:user_id (id, username, full_name, avatar_url)
`;

export class CheckinService {
  async create(userId: string, input: CreateCheckinInput) {
    const { data, error } = await supabaseAdmin
      .from('checkins')
      .insert({
        user_id: userId,
        location_id: input.location_id,
        note: input.note,
        visited_at: input.visited_at ?? new Date().toISOString().split('T')[0],
      })
      .select(checkinSelect)
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async getMine(userId: string) {
    const { data, error } = await supabaseAdmin
      .from('checkins')
      .select(checkinSelect)
      .eq('user_id', userId)
      .order('created_at', { ascending: false });

    if (error) {
      throw new AppError(error.message, 500);
    }

    return data ?? [];
  }

  async getByLocation(locationId: string) {
    const { data, error } = await supabaseAdmin
      .from('checkins')
      .select(checkinSelect)
      .eq('location_id', locationId)
      .order('created_at', { ascending: false })
      .limit(50);

    if (error) {
      throw new AppError(error.message, 500);
    }

    return data ?? [];
  }
}

export const checkinService = new CheckinService();
