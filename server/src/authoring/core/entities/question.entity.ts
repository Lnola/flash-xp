import { Entity, Property, ManyToOne } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { Deck, QuestionType } from '.';

type CreateQuestionProps = {
  text: string;
  answer?: string;
  deck: Deck;
  questionType: QuestionType;
};

@Entity({ tableName: 'question' })
export class Question extends BaseEntity {
  @Property()
  text!: string;

  @Property({ nullable: true })
  answer?: string;

  @ManyToOne(() => Deck, { hidden: true })
  deck!: Deck;

  @ManyToOne(() => QuestionType, { eager: true })
  questionType!: QuestionType;

  constructor({ text, answer, deck, questionType }: CreateQuestionProps) {
    super();
    this.text = text;
    this.answer = answer;
    this.deck = deck;
    this.questionType = questionType;
  }
}
