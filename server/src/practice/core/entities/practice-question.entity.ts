import { Collection, Entity, OneToMany, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { Box, PracticeAnswerOption } from '.';

@Entity({ tableName: 'question' })
export class PracticeQuestion extends BaseEntity {
  @Property()
  text!: string;

  @Property({ nullable: true })
  answer?: string;

  @Property()
  deckId!: number;

  @OneToMany(() => PracticeAnswerOption, (it) => it.question)
  answerOptions = new Collection<PracticeAnswerOption>(this);

  @OneToMany(() => Box, (it) => it.question)
  boxes = new Collection<Box>(this);
}
