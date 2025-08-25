import { z } from 'zod';

export const answersCountQuerySchema = z.object({
  interval: z.coerce.number().int().min(1).optional(),
});

export type AnswersCountQuery = z.infer<typeof answersCountQuerySchema>;
