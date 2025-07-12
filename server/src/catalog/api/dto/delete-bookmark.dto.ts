import { CatalogDeck, Learner } from 'catalog/core/entities';

export class DeleteBookmarkDto {
  deckId: CatalogDeck['id'];
  learnerId: Learner['id'];
}
