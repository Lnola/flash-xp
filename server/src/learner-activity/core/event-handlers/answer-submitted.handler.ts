import { Injectable } from '@nestjs/common';
import { LearnerEventService } from 'learner-activity/core/services';
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

  // TODO: check if this needs to be async
  handle({ payload }: AnswerSubmittedEvent) {
    this.learnerEventService.create(payload);
  }
}
