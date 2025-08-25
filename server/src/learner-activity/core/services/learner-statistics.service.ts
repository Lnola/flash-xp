import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import {
  AccuracyRate,
  DailyCorrectIncorrect,
} from 'learner-activity/core/models';
import { LearnerStatisticsRepository } from 'learner-activity/infrastructure';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class LearnerStatisticsService {
  constructor(
    @InjectRepository(LearnerEvent)
    private readonly learnerEventRepository: BaseEntityRepository<LearnerEvent>,
    private readonly learnerStatisticsRepository: LearnerStatisticsRepository,
  ) {}

  async fetchAnswersCount(
    learnerId: LearnerEvent['learnerId'],
    interval?: number,
  ): Promise<Result<number>> {
    try {
      const count = await this.learnerStatisticsRepository.getAnswersCount(
        learnerId,
        interval,
      );
      return Result.success(count);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch answers count.`);
    }
  }

  async fetchDailyCorrectIncorrect(
    learnerId: LearnerEvent['learnerId'],
  ): Promise<Result<DailyCorrectIncorrect[]>> {
    try {
      const dailyCorrectIncorrect =
        await this.learnerStatisticsRepository.getDailyCorrectIncorrect(
          learnerId,
        );
      return Result.success(dailyCorrectIncorrect);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch daily correct/incorrect answers.`);
    }
  }

  async fetchAccuracyRate(
    learnerId: LearnerEvent['learnerId'],
  ): Promise<Result<AccuracyRate>> {
    try {
      const accuracyRate =
        await this.learnerStatisticsRepository.getAccuracyRate(learnerId);
      return Result.success(accuracyRate);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch accuracy rate.`);
    }
  }
}
