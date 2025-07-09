import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { Question } from '.';

@Entity({ tableName: 'answer_option' })
export class AnswerOption extends BaseEntity {
  @Property({ length: 120 })
  text!: string;

  @Property()
  isCorrect!: boolean;

  @ManyToOne(() => Question)
  question!: Question;
}
