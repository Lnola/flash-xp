import { Entity, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

@Entity({ tableName: 'deck' })
export class Deck extends BaseEntity {
  @Property()
  title!: string;

  @Property()
  description!: string;
}
