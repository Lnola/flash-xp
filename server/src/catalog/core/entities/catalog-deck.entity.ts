import { Collection, Entity, OneToMany, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { CatalogQuestion } from './catalog-question.entity';

@Entity({ tableName: 'deck' })
export class CatalogDeck extends BaseEntity {
  @Property()
  title!: string;

  @Property()
  description!: string;

  @Property()
  authorId!: number;

  @OneToMany(() => CatalogQuestion, (question) => question.deck)
  questions = new Collection<CatalogQuestion>(this);
}
