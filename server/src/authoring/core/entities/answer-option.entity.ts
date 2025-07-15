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

  constructor({ text, isCorrect, question }: AnswerOptionConstructorProps) {
    super();
    this.text = text;
    this.isCorrect = isCorrect;
    this.question = question;
  }

  clone(question: Question): AnswerOption {
    return new AnswerOption({ ...this, question });
  }
}

export type AnswerOptionConstructorProps = {
  text: string;
  isCorrect: boolean;
  question: Question;
};
