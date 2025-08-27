import { Injectable } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import {
  AccuracyRate,
  DailyCorrectIncorrect,
  IncorrectlyAnsweredQuestionModel,
} from 'learner-activity/core/models';
import { LearnerStatisticsRepository } from 'learner-activity/infrastructure';
import { Result } from 'shared/helpers/result';

// TODO: Remove the console.logs
@Injectable()
export class LearnerStatisticsService {
  constructor(
    private readonly learnerStatisticsRepository: LearnerStatisticsRepository,
  ) {}

  async fetchDailyStreak(
    learnerId: LearnerEvent['learnerId'],
  ): Promise<Result<number>> {
    try {
      const streak =
        await this.learnerStatisticsRepository.getDailyStreak(learnerId);
      return Result.success(streak);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch daily streak.`);
    }
  }

  async fetchAnswerCount(
    learnerId: LearnerEvent['learnerId'],
    interval?: number,
  ): Promise<Result<number>> {
    try {
      const count = await this.learnerStatisticsRepository.getAnswerCount(
        learnerId,
        interval,
      );
      return Result.success(count);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch answers count.`);
    }
  }

  async fetchDeckCount(
    learnerId: LearnerEvent['learnerId'],
    interval?: number,
  ): Promise<Result<number>> {
    try {
      const count = await this.learnerStatisticsRepository.getDeckCount(
        learnerId,
        interval,
      );
      return Result.success(count);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch decks count.`);
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

  async fetchCommonIncorrectlyAnsweredQuestions(
    learnerId: LearnerEvent['learnerId'],
  ): Promise<Result<IncorrectlyAnsweredQuestionModel[]>> {
    try {
      const answers =
        await this.learnerStatisticsRepository.getCommonIncorrectlyAnsweredQuestionIds(
          learnerId,
        );
      return Result.success(answers);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch most common wrong answers.`);
    }
  }
}
