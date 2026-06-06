import { z } from 'zod';

export const createPostSchema = z.object({
  location_id: z.string().uuid().optional(),
  caption: z.string().max(2000).optional(),
});

export const updatePostSchema = z.object({
  caption: z.string().max(2000).optional(),
  location_id: z.string().uuid().nullable().optional(),
});

export type CreatePostInput = z.infer<typeof createPostSchema>;
export type UpdatePostInput = z.infer<typeof updatePostSchema>;
