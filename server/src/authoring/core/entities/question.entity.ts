import { Entity, Property, ManyToOne } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { Deck, QuestionType } from '.';

type CreateQuestionProps = {
  text: string;
  deck: Deck;
  questionType: QuestionType;
};

@Entity({ tableName: 'question' })
export class Question extends BaseEntity {
  @Property()
  text!: string;

  @ManyToOne(() => Deck, { hidden: true })
  deck!: Deck;

  @ManyToOne(() => QuestionType, { eager: true })
  questionType!: QuestionType;

  constructor({ text, deck, questionType }: CreateQuestionProps) {
    super();
    this.text = text;
    this.deck = deck;
    this.questionType = questionType;
  }
}
