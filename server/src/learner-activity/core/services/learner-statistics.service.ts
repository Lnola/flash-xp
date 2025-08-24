import { Injectable } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import {
  DailyCorrectIncorrect,
  LearnerEventRepository,
} from 'learner-activity/infrastructure';
import { Result } from 'shared/helpers/result';

@Injectable()
export class LearnerStatisticsService {
  constructor(
    private readonly learnerEventRepository: LearnerEventRepository,
  ) {}

  async fetchDailyCorrectIncorrect(
    learnerId: LearnerEvent['learnerId'],
  ): Promise<Result<DailyCorrectIncorrect[]>> {
    try {
      const dailyCorrectIncorrect =
        await this.learnerEventRepository.getDailyCorrectIncorrect(learnerId);
      return Result.success(dailyCorrectIncorrect);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch daily correct/incorrect answers.`);
    }
  }
}
