import { Injectable } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import { LearnerStatisticsRepository } from 'learner-activity/infrastructure';
import { Result } from 'shared/helpers/result';
import { DailyCorrectIncorrect } from '../models';

@Injectable()
export class LearnerStatisticsService {
  constructor(
    private readonly learnerStatisticsRepository: LearnerStatisticsRepository,
  ) {}

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
}
