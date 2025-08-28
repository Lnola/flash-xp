import { z } from 'zod';
import { QUESTION_TYPE_NAMES } from 'shared/constants';

export const catalogDeckQuerySchema = z.object({
  questionType: z.enum(QUESTION_TYPE_NAMES).optional(),
  title: z.string().min(1).optional(),
  bookmarked: z.stringbool().optional(),
  authored: z.stringbool().optional(),
  limit: z.coerce.number().int().min(1).optional().default(100),
  offset: z.coerce.number().int().min(0).optional().default(0),
});

export type CatalogDeckQuery = z.infer<typeof catalogDeckQuerySchema>;
