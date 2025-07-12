import { CatalogDeck, Learner } from 'catalog/core/entities';

export class CreateBookmarkDto {
  deckId: CatalogDeck['id'];
  learnerId: Learner['id'];
}
