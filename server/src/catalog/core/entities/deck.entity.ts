import { Collection, Entity, OneToMany, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { Question } from './question.entity';

@Entity({ tableName: 'deck' })
export class Deck extends BaseEntity {
  @Property({ length: 50 })
  title!: string;

  @Property({ length: 300 })
  description!: string;

  @OneToMany(() => Question, (question) => question.deck)
  questions = new Collection<Question>(this);
}
