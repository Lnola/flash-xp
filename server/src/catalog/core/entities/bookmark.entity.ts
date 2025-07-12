import { Entity, Property, Unique } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { CatalogDeck, Learner } from '.';

@Entity({ tableName: 'bookmark' })
@Unique({ properties: ['deckId', 'learnerId'] })
export class Bookmark extends BaseEntity {
  @Property()
  deckId!: CatalogDeck['id'];

  @Property()
  learnerId!: Learner['id'];

  constructor(deckId: CatalogDeck['id'], learnerId: Learner['id']) {
    super();
    this.deckId = deckId;
    this.learnerId = learnerId;
  }
}
