import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class LearnerEventService {
  constructor(
    @InjectRepository(LearnerEvent)
    private readonly learnerEventRepository: BaseEntityRepository<LearnerEvent>,
  ) {}

  create({
    questionId,
    learnerId,
    isCorrect,
  }: CreateLearnerEventPayload): Result<void> {
    try {
      console.log(questionId, learnerId, isCorrect);
      return Result.success();
    } catch {
      return Result.failure(`Failed to create learner event.`);
    }
  }
}

// TODO: update once LearnerEvent entity is updated
type CreateLearnerEventPayload = {
  questionId: number;
  learnerId: number;
  isCorrect: boolean;
};
