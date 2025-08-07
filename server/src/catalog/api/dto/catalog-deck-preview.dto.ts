import { CatalogDeck } from 'catalog/core/entities';

export type CatalogDeckPreview = Pick<
  CatalogDeck,
  'id' | 'title' | 'description' | 'questions'
> & {
  isBookmarked: boolean;
  isCurrentUserAuthor: boolean;
};
