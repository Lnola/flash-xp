import { BaseEvent } from './base.event';

export class AnswerSubmittedEvent extends BaseEvent<{
  questionId: number;
  learnerId: number;
  isCorrect: boolean;
}> {}
