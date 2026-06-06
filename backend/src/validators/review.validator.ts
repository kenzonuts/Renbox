import { z } from 'zod';

export const createReviewSchema = z.object({
  rating: z.number().int().min(1).max(5),
  review_text: z.string().max(2000).optional(),
  trail_condition: z.string().max(200).optional(),
  crowd_level: z.string().max(200).optional(),
  visited_at: z.string().date().optional(),
});

export const updateReviewSchema = createReviewSchema.partial();

export type CreateReviewInput = z.infer<typeof createReviewSchema>;
export type UpdateReviewInput = z.infer<typeof updateReviewSchema>;
