import { CatalogDeck, Learner } from 'catalog/core/entities';
import { parseQuery, ParseQueryHandlers } from 'shared/helpers/parse-query';
import { CatalogDeckQuery } from './catalog-deck-query.schema';

export const parseCatalogDeckQuery = (
  query: CatalogDeckQuery,
  learnerId?: Learner['id'],
) => {
  const handlers: ParseQueryHandlers<CatalogDeckQuery, CatalogDeck> = {
    // TODO: implement the popular handler
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
