import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { PracticeQuestion } from '.';

@Entity({ tableName: 'answer_option' })
export class PracticeAnswerOption extends BaseEntity {
  @Property({ length: 120 })
  text!: string;

  @Property()
  isCorrect!: boolean;

  @ManyToOne(() => PracticeQuestion)
  question!: PracticeQuestion;
}
