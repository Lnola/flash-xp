import {
  Cascade,
  Collection,
  Entity,
  OneToMany,
  Property,
} from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { Author, CreateAnswerOptionsProps, Question } from '.';

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
  })
  questions = new Collection<Question>(this);

  constructor({ authorId, title, description }: CreateDeckProps) {
    super();
    this.authorId = authorId;
    this.title = title;
    this.description = description;
  }

  setQuestions(questions: Question[]): void {
    this.questions.set(questions);
  }

  createQuestions(questionsProps: CreateQuestionsProps): void {
    const newQuestions = questionsProps.map((questionProps) => {
      if (!questionProps.questionType) {
        throw new Error('Question type is required');
      }
      const newQuestion = new Question({ ...questionProps, deck: this });
      if (questionProps.answerOptionsProps) {
        newQuestion.createAnswerOptions(questionProps.answerOptionsProps);
      }
      return newQuestion;
    });
    this.setQuestions(newQuestions);
  }

  clone(): Deck {
    const clonedDeck = new Deck(this);
    const clonedQuestions = this.questions.map((question) =>
      question.clone(clonedDeck),
    );
    clonedDeck.setQuestions(clonedQuestions);
    return clonedDeck;
  }

  fork(authorId: Author['id']): Deck {
    const forkedDeck = this.clone();
    forkedDeck.authorId = authorId;
    forkedDeck.title = `${this.title} (Forked)`;
    return forkedDeck;
  }
}

type CreateDeckProps = {
  authorId: number;
  title: string;
  description: string;
};

type CreateQuestionsProps = {
  text: Question['text'];
  answer: Question['answer'];
  questionType: Question['questionType'];
  answerOptionsProps?: CreateAnswerOptionsProps;
}[];
