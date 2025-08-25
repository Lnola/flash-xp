import { Injectable } from '@nestjs/common';
import { LearnerEventService } from 'learner-activity/core/services';
import { LearnerEventTypes } from 'shared/constants';
import { AnswerSubmittedEvent, BaseEventHandler } from 'shared/events';
import { Mediator } from 'shared/mediator';

@Injectable()
export class AnswerSubmittedEventHandler extends BaseEventHandler<AnswerSubmittedEvent> {
  constructor(
    private readonly learnerEventService: LearnerEventService,
    mediator: Mediator,
  ) {
    super(mediator, AnswerSubmittedEvent.name);
  }

  handle(event: AnswerSubmittedEvent) {
    const { learnerId, questionId, deckId, isCorrect } = event.payload;
    const payload = { questionId, deckId, isCorrect };
    void this.learnerEventService.create({
      learnerId,
      payload,
      type: LearnerEventTypes.ANSWER_SUBMITTED,
    });
  }
}
