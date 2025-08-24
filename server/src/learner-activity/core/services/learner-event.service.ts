import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import {
  CreateLearnerEventProps,
  LearnerEvent,
} from 'learner-activity/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class LearnerEventService {
  constructor(
    @InjectRepository(LearnerEvent)
    private readonly learnerEventRepository: BaseEntityRepository<LearnerEvent>,
  ) {}

  async create({
    learnerId,
    type,
    payload,
  }: CreateLearnerEventProps): Promise<Result<void>> {
    try {
      const newLearnerEvent = new LearnerEvent({ learnerId, type, payload });
      await this.learnerEventRepository.persistAndFlush(newLearnerEvent);
      return Result.success();
    } catch {
      return Result.failure(`Failed to create learner event.`);
    }
  }
}
