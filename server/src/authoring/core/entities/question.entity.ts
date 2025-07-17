import {
  Entity,
  Property,
  ManyToOne,
  OneToMany,
  Collection,
  Cascade,
} from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { AnswerOption, CreateAnswerOptionProps, Deck, QuestionType } from '.';

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

  @OneToMany(() => AnswerOption, (answerOption) => answerOption.question, {
    cascade: [Cascade.REMOVE, Cascade.PERSIST],
  })
  answerOptions = new Collection<AnswerOption>(this);

  constructor({ text, answer, deck, questionType }: QuestionConstructorProps) {
    super();
    this.text = text;
    this.answer = answer;
    this.deck = deck;
    this.questionType = questionType;
  }

  private _setAnswerOptions(answerOptions: AnswerOption[]): void {
    this.answerOptions.set(answerOptions);
  }

  static create({
    answerOptionsProps,
    ...data
  }: CreateQuestionProps): Question {
    const newQuestion = new Question(data);
    if (answerOptionsProps) {
      const newAnswerOptions =
        newQuestion._createAnswerOptions(answerOptionsProps);
      newQuestion._setAnswerOptions(newAnswerOptions);
    }
    return newQuestion;
  }

  private _createAnswerOptions(
    answerOptionsProps: Omit<CreateAnswerOptionProps, 'question'>[],
  ): AnswerOption[] {
    return answerOptionsProps.map((answerOption) =>
      AnswerOption.create({
        ...answerOption,
        question: this,
      }),
    );
  }

  update({
    text,
    answer,
    questionType,
    answerOptionsProps,
  }: UpdateQuestionProps): void {
    this.text = text;
    this.answer = answer;
    this.questionType = questionType;
    if (answerOptionsProps) {
      const newAnswerOptions = this._updateAnswerOptions(answerOptionsProps);
      this._setAnswerOptions(newAnswerOptions);
    }
  }

  private _updateAnswerOptions(
    answerOptionsProps: Omit<CreateAnswerOptionProps, 'question'>[],
  ): AnswerOption[] {
    const existingAnswerOptions = this.answerOptions.getItems();
    const answerOptions = answerOptionsProps.map((answerOptionProps) => {
      const existingOption = existingAnswerOptions.find(
        (it) => it.text === answerOptionProps.text,
      );
      const payload = { ...answerOptionProps, question: this };
      if (!existingOption) return AnswerOption.create(payload);
      existingOption.update(payload);
      return existingOption;
    });
    return answerOptions;
  }

  clone(deck: Deck): Question {
    const clonedQuestion = new Question({ ...this, deck });
    const clonedAnswerOptions = this.answerOptions.map((answerOption) =>
      answerOption.clone(clonedQuestion),
    );
    clonedQuestion._setAnswerOptions(clonedAnswerOptions);
    return clonedQuestion;
  }
}

type QuestionConstructorProps = {
  text: string;
  answer?: string;
  deck: Deck;
  questionType: QuestionType;
};

export type CreateQuestionProps = QuestionConstructorProps & {
  answerOptionsProps?: Omit<CreateAnswerOptionProps, 'question'>[];
};
export type UpdateQuestionProps = QuestionConstructorProps & {
  answerOptionsProps?: Omit<CreateAnswerOptionProps, 'question'>[];
};
