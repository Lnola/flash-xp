import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { CatalogDeck, Learner } from '.';

@Entity({ tableName: 'bookmark' })
export class Bookmark extends BaseEntity {
  @Property()
  deckId!: CatalogDeck['id'];

  @ManyToOne(() => Learner)
  learner!: Learner;

  constructor(deckId: CatalogDeck['id'], learner: Learner) {
    super();
    this.deckId = deckId;
    this.learner = learner;
  }
}
