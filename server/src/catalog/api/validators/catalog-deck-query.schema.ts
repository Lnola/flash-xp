import { z } from 'zod';
import { CatalogDeck, Learner } from 'catalog/core/entities';
import { QUESTION_TYPE_NAMES } from 'shared/constants';
import { parseQuery, ParseQueryHandlers } from 'shared/helpers/parse-query';

// TODO: think about naming and location of the CatalogDeckQuery type
export const catalogDeckQuerySchema = z.object({
  questionType: z.enum(QUESTION_TYPE_NAMES).optional(),
  title: z.string().min(1).optional(),
  popular: z.coerce.boolean().optional(),
  bookmarked: z.coerce.boolean().optional(),
  authored: z.coerce.boolean().optional(),
  inProgress: z.coerce.boolean().optional(),
  limit: z.coerce.number().int().min(1).optional().default(100),
  offset: z.coerce.number().int().min(0).optional().default(0),
});

export type CatalogDeckQuery = z.infer<typeof catalogDeckQuerySchema>;

export const parseCatalogDeckQuery = (
  query: CatalogDeckQuery,
  learnerId?: Learner['id'],
) => {
  const handlers: ParseQueryHandlers<CatalogDeckQuery, CatalogDeck> = {
    questionType: (where, filters) => {
      where.questions = { questionType: { name: filters.questionType } };
    },
    bookmarked: (where) => {
      if (!learnerId) {
        throw new Error('Learner ID is required to filter by bookmarks');
      }
      where.bookmarks = { learnerId };
    },
    authored: (where) => {
      if (!learnerId) {
        throw new Error('Learner ID is required to filter by authorship');
      }
      where.authorId = learnerId;
    },
  };

  return parseQuery(query, handlers);
};
