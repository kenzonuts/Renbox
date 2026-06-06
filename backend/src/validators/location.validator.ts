import { z } from 'zod';

const categoryEnum = z.enum(['mountain', 'camping', 'waterfall', 'beach', 'forest', 'lake']);
const difficultyEnum = z.enum(['easy', 'medium', 'hard', 'extreme']);

export const createLocationSchema = z.object({
  name: z.string().min(2).max(200),
  category: categoryEnum,
  province: z.string().optional(),
  city: z.string().optional(),
  address: z.string().optional(),
  latitude: z.number().optional(),
  longitude: z.number().optional(),
  altitude: z.number().int().optional(),
  difficulty: difficultyEnum.optional(),
  description: z.string().optional(),
  duration: z.string().optional(),
});

export const searchLocationSchema = z.object({
  q: z.string().optional(),
  page: z.coerce.number().int().min(1).default(1),
  limit: z.coerce.number().int().min(1).max(50).default(20),
});

export type CreateLocationInput = z.infer<typeof createLocationSchema>;
