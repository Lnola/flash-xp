import { Controller, Get, NotFoundException } from '@nestjs/common';
import { LearnerStatisticsService } from 'learner-activity/core/services';
import { DailyCorrectIncorrect } from 'learner-activity/infrastructure';
import { User } from 'shared/decorators';

@Controller('statistics')
export class LearnerStatisticsController {
  constructor(
    private readonly learnerStatisticsService: LearnerStatisticsService,
  ) {}

  @Get('daily-correct-incorrect')
  async fetchDailyCorrectIncorrect(
    @User('id') learnerId: number,
  ): Promise<DailyCorrectIncorrect[]> {
    const { error, data } =
      await this.learnerStatisticsService.fetchDailyCorrectIncorrect(learnerId);
    if (error || !data) throw new NotFoundException(error);
    return data;
  }
}
