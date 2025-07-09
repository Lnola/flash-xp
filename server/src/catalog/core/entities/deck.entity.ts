import { Entity, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

@Entity({ tableName: 'deck' })
export class Deck extends BaseEntity {
  @Property({ length: 50 })
  title!: string;

  @Property({ length: 300 })
  description!: string;
}
