import { z } from 'zod';

export const createCheckinSchema = z.object({
  location_id: z.string().uuid(),
  note: z.string().max(500).optional(),
  visited_at: z.string().date().optional(),
});

export type CreateCheckinInput = z.infer<typeof createCheckinSchema>;
