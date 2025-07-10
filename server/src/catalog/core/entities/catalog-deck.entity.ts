import { Entity, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

@Entity({ tableName: 'deck' })
export class CatalogDeck extends BaseEntity {
  @Property()
  title!: string;

  @Property()
  description!: string;

  @Property()
  authorId!: number;
}
