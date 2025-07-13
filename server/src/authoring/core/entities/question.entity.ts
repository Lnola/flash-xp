import {
  Entity,
  Property,
  ManyToOne,
  OneToMany,
  Collection,
} from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { AnswerOption, Deck, QuestionType } from '.';

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

  @OneToMany(() => AnswerOption, (answerOption) => answerOption.question)
  answerOptions = new Collection<AnswerOption>(this);

  constructor({ text, answer, deck, questionType }: CreateQuestionProps) {
    super();
    this.text = text;
    this.answer = answer;
    this.deck = deck;
    this.questionType = questionType;
  }
}
