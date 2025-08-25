import { Controller, Get, NotFoundException } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import {
  AccuracyRate,
  DailyCorrectIncorrect,
} from 'learner-activity/core/models';
import { LearnerStatisticsService } from 'learner-activity/core/services';
import { User } from 'shared/decorators';

@Controller('statistics')
export class LearnerStatisticsController {
  constructor(
    private readonly learnerStatisticsService: LearnerStatisticsService,
  ) {}

  @Get('daily-correct-incorrect')
  async fetchDailyCorrectIncorrect(
    @User('id') learnerId: LearnerEvent['learnerId'],
  ): Promise<DailyCorrectIncorrect[]> {
    const { error, data } =
      await this.learnerStatisticsService.fetchDailyCorrectIncorrect(learnerId);
    if (error || !data) throw new NotFoundException(error);
    return data;
  }

  @Get('accuracy-rate')
  async fetchAccuracyRate(
    @User('id') learnerId: LearnerEvent['learnerId'],
  ): Promise<AccuracyRate> {
    const { error, data } =
      await this.learnerStatisticsService.fetchAccuracyRate(learnerId);
    if (error || !data) throw new NotFoundException(error);
    return data;
  }
}
