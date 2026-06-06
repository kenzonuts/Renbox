import { supabaseAdmin } from '../config/supabase';
import { AppError } from '../middleware/error.middleware';

export class WishlistService {
  async add(userId: string, locationId: string) {
    const { error } = await supabaseAdmin
      .from('wishlists')
      .insert({ user_id: userId, location_id: locationId });

    if (error) {
      if (error.code === '23505') {
        throw new AppError('Already in wishlist', 409);
      }
      throw new AppError(error.message, 400);
    }

    return { location_id: locationId };
  }

  async remove(userId: string, locationId: string) {
    const { error } = await supabaseAdmin
      .from('wishlists')
      .delete()
      .eq('user_id', userId)
      .eq('location_id', locationId);

    if (error) {
      throw new AppError(error.message, 400);
    }
  }

  async getMine(userId: string) {
    const { data, error } = await supabaseAdmin
      .from('wishlists')
      .select('*, locations(*)')
      .eq('user_id', userId)
      .order('created_at', { ascending: false });

    if (error) {
      throw new AppError(error.message, 500);
    }

    return data ?? [];
  }
}

export const wishlistService = new WishlistService();
