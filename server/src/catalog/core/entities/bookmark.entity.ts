import { Entity, ManyToOne, Property, Unique } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { CatalogDeck, Learner } from '.';

@Entity({ tableName: 'bookmark' })
@Unique({ properties: ['deck', 'learnerId'] })
export class Bookmark extends BaseEntity {
  @ManyToOne(() => CatalogDeck)
  deck!: CatalogDeck;

  @Property()
  learnerId!: Learner['id'];

  constructor(deck: CatalogDeck, learnerId: Learner['id']) {
    super();
    this.deck = deck;
    this.learnerId = learnerId;
  }
}
