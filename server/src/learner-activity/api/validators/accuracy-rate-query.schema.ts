import { z } from 'zod';
import { QUESTION_TYPE_NAMES } from 'shared/constants';

export const accuracyRateQuerySchema = z.object({
  questionType: z.enum(QUESTION_TYPE_NAMES).optional(),
});

export type AccuracyRateQuery = z.infer<typeof accuracyRateQuerySchema>;
