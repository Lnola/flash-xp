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

  static create(props: AnswerOptionConstructorProps): AnswerOption {
    return new AnswerOption(props);
  }

  update({ text, isCorrect }: UpdateAnswerOptionProps): void {
    this.text = text;
    this.isCorrect = isCorrect;
  }

  clone(question: Question): AnswerOption {
    return new AnswerOption({ ...this, question });
  }
}

type AnswerOptionConstructorProps = {
  text: string;
  isCorrect: boolean;
  question: Question;
};

export type CreateAnswerOptionProps = AnswerOptionConstructorProps;
export type UpdateAnswerOptionProps = AnswerOptionConstructorProps;
