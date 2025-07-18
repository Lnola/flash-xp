import {
  Cascade,
  Collection,
  Entity,
  OneToMany,
  Property,
} from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { Author, CreateQuestionProps, Question } from '.';

@Entity({ tableName: 'deck' })
export class Deck extends BaseEntity {
  @Property({ length: 50 })
  title!: string;

  @Property({ length: 300 })
  description!: string;

  @Property()
  authorId!: Author['id'];

  @OneToMany(() => Question, (question) => question.deck, {
    cascade: [Cascade.REMOVE, Cascade.PERSIST],
    orphanRemoval: true,
  })
  questions = new Collection<Question>(this);

  constructor({ authorId, title, description }: DeckConstructorProps) {
    super();
    this.authorId = authorId;
    this.title = title;
    this.description = description;
  }

  private _setQuestions(questions: Question[]): void {
    this.questions.set(questions);
  }

  static create({ questionsProps, ...data }: CreateDeckProps): Deck {
    const newDeck = new Deck(data);
    if (questionsProps) {
      const newQuestions = newDeck._createQuestions(questionsProps);
      newDeck._setQuestions(newQuestions);
    }
    return newDeck;
  }

  private _createQuestions(
    questionsProps: Omit<CreateQuestionProps, 'deck'>[],
  ): Question[] {
    return questionsProps.map((question) =>
      Question.create({
        ...question,
        deck: this,
      }),
    );
  }

  update({ title, description, questionsProps }: UpdateDeckProps): void {
    this.title = title;
    this.description = description;
    if (questionsProps) {
      const newQuestions = this._updateQuestions(questionsProps);
      this._setQuestions(newQuestions);
    }
  }

  private _updateQuestions(
    questionsProps: Omit<CreateQuestionProps, 'deck'>[],
  ): Question[] {
    const existingQuestions = this.questions.getItems();
    const questions = questionsProps.map((questionProps) => {
      const existingQuestion = existingQuestions.find(
        (it) => it.text === questionProps.text,
      );
      const payload = { ...questionProps, deck: this };
      if (!existingQuestion) return Question.create(payload);
      existingQuestion.update(payload);
      return existingQuestion;
    });
    return questions;
  }

  clone(): Deck {
    const clonedDeck = new Deck(this);
    const clonedQuestions = this.questions.map((question) =>
      question.clone(clonedDeck),
    );
    clonedDeck._setQuestions(clonedQuestions);
    return clonedDeck;
  }

  fork(authorId: Author['id']): Deck {
    const forkedDeck = this.clone();
    forkedDeck.authorId = authorId;
    forkedDeck.title = `${this.title} (Forked)`;
    return forkedDeck;
  }
}

type DeckConstructorProps = {
  authorId: number;
  title: string;
  description: string;
};

export type CreateDeckProps = DeckConstructorProps & {
  questionsProps?: Omit<CreateQuestionProps, 'deck'>[];
};
export type UpdateDeckProps = DeckConstructorProps & {
  questionsProps?: Omit<CreateQuestionProps, 'deck'>[];
};
