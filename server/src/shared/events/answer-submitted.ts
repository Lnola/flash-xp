import { IntegrationEvent } from './integration.event';

export class AnswerSubmittedEvent extends IntegrationEvent<{
  questionId: number;
  learnerId: number;
  isCorrect: boolean;
}> {}
