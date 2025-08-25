import { BaseEvent } from './base.event';

export class AnswerSubmittedEvent extends BaseEvent<{
  questionId: number;
  learnerId: number;
  deckId: number;
  isCorrect: boolean;
}> {}
