import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { AnswerSubmittedEvent } from 'shared/events';
import { Result } from 'shared/helpers/result';

@Injectable()
export class LearnerEventService {
  constructor(
    @InjectRepository(LearnerEvent)
    private readonly learnerEventRepository: BaseEntityRepository<LearnerEvent>,
  ) {}

  create(event: AnswerSubmittedEvent): Result<void> {
    try {
      console.log(event);
      return Result.success();
    } catch {
      return Result.failure(`Failed to create learner event.`);
    }
  }
}
