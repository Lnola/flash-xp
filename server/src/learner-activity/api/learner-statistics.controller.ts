import { Controller, Get, NotFoundException, Query } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import {
  AccuracyRate,
  DailyCorrectIncorrect,
} from 'learner-activity/core/models';
import { LearnerStatisticsService } from 'learner-activity/core/services';
import { User } from 'shared/decorators';
import { ZodValidationPipe } from 'shared/pipes';
import { AnswersCountQuery, answersCountQuerySchema } from './validators';

@Controller('statistics')
export class LearnerStatisticsController {
  constructor(
    private readonly learnerStatisticsService: LearnerStatisticsService,
  ) {}

  @Get('streak')
  async fetchDailyStreak(
    @User('id') learnerId: LearnerEvent['learnerId'],
  ): Promise<number> {
    const { error, data } =
      await this.learnerStatisticsService.fetchDailyStreak(learnerId);
    if (error || (!data && data !== 0)) throw new NotFoundException(error);
    return data;
  }

  @Get('answers/count')
  async fetchAnswersCount(
    @Query(new ZodValidationPipe(answersCountQuerySchema))
    { interval }: AnswersCountQuery,
    @User('id')
    learnerId: LearnerEvent['learnerId'],
  ): Promise<number> {
    const { error, data } =
      await this.learnerStatisticsService.fetchAnswersCount(
        learnerId,
        interval,
      );
    if (error || (!data && data !== 0)) throw new NotFoundException(error);
    return data;
  }

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
