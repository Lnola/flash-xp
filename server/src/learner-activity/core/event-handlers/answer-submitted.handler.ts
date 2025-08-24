import { Injectable } from '@nestjs/common';
import { AnswerSubmittedEvent, BaseEventHandler } from 'shared/events';
import { Mediator } from 'shared/mediator';

@Injectable()
export class AnswerSubmittedEventHandler extends BaseEventHandler<AnswerSubmittedEvent> {
  constructor(mediator: Mediator) {
    super(mediator, AnswerSubmittedEvent.name);
  }

  handle(event: AnswerSubmittedEvent) {
    console.log(event.payload);
  }
}
