import { supabaseAdmin } from '../config/supabase';
import { CreateReviewInput, UpdateReviewInput } from '../validators/review.validator';
import { AppError } from '../middleware/error.middleware';

const reviewSelect = `
  *,
  profiles:user_id (id, username, full_name, avatar_url)
`;

export class ReviewService {
  async create(locationId: string, userId: string, input: CreateReviewInput) {
    const { data, error } = await supabaseAdmin
      .from('location_reviews')
      .insert({
        location_id: locationId,
        user_id: userId,
        ...input,
      })
      .select(reviewSelect)
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async getByLocation(locationId: string) {
    const { data, error } = await supabaseAdmin
      .from('location_reviews')
      .select(reviewSelect)
      .eq('location_id', locationId)
      .order('created_at', { ascending: false });

    if (error) {
      throw new AppError(error.message, 500);
    }

    return data ?? [];
  }

  async update(reviewId: string, userId: string, input: UpdateReviewInput) {
    const { data: review } = await supabaseAdmin
      .from('location_reviews')
      .select('user_id')
      .eq('id', reviewId)
      .single();

    if (!review || review.user_id !== userId) {
      throw new AppError('Review not found or unauthorized', 403);
    }

    const { data, error } = await supabaseAdmin
      .from('location_reviews')
      .update(input)
      .eq('id', reviewId)
      .select(reviewSelect)
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async delete(reviewId: string, userId: string) {
    const { data: review } = await supabaseAdmin
      .from('location_reviews')
      .select('user_id')
      .eq('id', reviewId)
      .single();

    if (!review || review.user_id !== userId) {
      throw new AppError('Review not found or unauthorized', 403);
    }

    const { error } = await supabaseAdmin.from('location_reviews').delete().eq('id', reviewId);
    if (error) {
      throw new AppError(error.message, 400);
    }
  }
}

export const reviewService = new ReviewService();
