import {
  Collection,
  Entity,
  Formula,
  OneToMany,
  Property,
} from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { CatalogQuestion } from '.';

@Entity({ tableName: 'deck' })
export class CatalogDeck extends BaseEntity {
  @Property()
  title!: string;

  @Property()
  description!: string;

  @Property()
  authorId!: number;

  @OneToMany(() => CatalogQuestion, (question) => question.deck)
  questions? = new Collection<CatalogQuestion>(this);

  // This value is calculated on every fetch. This behavior can be stopped
  // by setting { lazy: true } here. However, that will require all uses to
  // explicitly set { populate : ['questionCount'] }.
  @Formula(
    (alias) =>
      `(SELECT CAST(COUNT(*) as INT) 
        FROM question q 
        WHERE q.deck_id = ${alias}.id)`,
  )
  questionCount!: number;
}
