import { Controller, Get, NotFoundException, Query } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import {
  AccuracyRate,
  DailyCorrectIncorrect,
  IncorrectlyAnsweredQuestion,
  QuestionTypeStatistics,
} from 'learner-activity/core/models';
import { LearnerStatisticsService } from 'learner-activity/core/services';
import { User } from 'shared/decorators';
import { ZodValidationPipe } from 'shared/pipes';
import {
  AccuracyRateQuery,
  accuracyRateQuerySchema,
  AnswersCountQuery,
  answersCountQuerySchema,
} from './validators';

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

  @Get('answer-count')
  async fetchAnswerCount(
    @Query(new ZodValidationPipe(answersCountQuerySchema))
    { interval }: AnswersCountQuery,
    @User('id')
    learnerId: LearnerEvent['learnerId'],
  ): Promise<number> {
    const { error, data } =
      await this.learnerStatisticsService.fetchAnswerCount(learnerId, interval);
    if (error || (!data && data !== 0)) throw new NotFoundException(error);
    return data;
  }

  @Get('deck-count')
  async fetchDeckCount(
    @Query(new ZodValidationPipe(answersCountQuerySchema))
    { interval }: AnswersCountQuery,
    @User('id')
    learnerId: LearnerEvent['learnerId'],
  ): Promise<number> {
    const { error, data } = await this.learnerStatisticsService.fetchDeckCount(
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
    @Query(new ZodValidationPipe(accuracyRateQuerySchema))
    query: AccuracyRateQuery,
  ): Promise<AccuracyRate> {
    const { error, data } =
      await this.learnerStatisticsService.fetchAccuracyRate(
        learnerId,
        query.questionType,
      );
    if (error || !data) throw new NotFoundException(error);
    return data;
  }

  @Get('common-incorrect-questions')
  async fetchCommonIncorrectlyAnsweredQuestions(
    @User('id') learnerId: LearnerEvent['learnerId'],
  ): Promise<IncorrectlyAnsweredQuestion[]> {
    const { error, data } =
      await this.learnerStatisticsService.fetchCommonIncorrectlyAnsweredQuestions(
        learnerId,
      );
    if (error || !data) throw new NotFoundException(error);
    return data;
  }

  @Get('question-type-occurrence-count')
  async fetchQuestionTypeStatistics(
    @User('id') learnerId: LearnerEvent['learnerId'],
  ): Promise<QuestionTypeStatistics> {
    const { error, data } =
      await this.learnerStatisticsService.fetchQuestionTypeStatistics(
        learnerId,
      );
    if (error || !data) throw new NotFoundException(error);
    return data;
  }
}
