import { Deck, Question } from 'authoring/core/entities';
import { CreateQuestionProps, QuestionFactory } from '.';

export class DeckFactory {
  static create(data: CreateDeckProps): Deck {
    const newDeck = new Deck(data);
    if (data.questions) {
      const newQuestions = this._createQuestions(newDeck, data.questions);
      newDeck.setQuestions(newQuestions);
    }
    return newDeck;
  }

  private static _createQuestions(
    newDeck: Deck,
    questionProps: Omit<CreateQuestionProps, 'deck'>[],
  ): Question[] {
    return questionProps.map((question) =>
      QuestionFactory.create({
        ...question,
        deck: newDeck,
      }),
    );
  }
}

export type CreateDeckProps = {
  authorId: Deck['authorId'];
  title: Deck['title'];
  description: Deck['description'];
  questions?: Omit<CreateQuestionProps, 'deck'>[];
};
