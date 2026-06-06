import { z } from 'zod';

export const updateProfileSchema = z.object({
  full_name: z.string().min(2).max(100).optional(),
  bio: z.string().max(500).optional(),
  city: z.string().max(100).optional(),
  interests: z.array(z.string()).max(10).optional(),
});

export type UpdateProfileInput = z.infer<typeof updateProfileSchema>;
