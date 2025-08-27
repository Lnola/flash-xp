import { Injectable } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import {
  AccuracyRate,
  DailyCorrectIncorrect,
  IncorrectlyAnsweredQuestion,
  QuestionTypeStatistics,
} from 'learner-activity/core/models';
import { LearnerStatisticsRepository } from 'learner-activity/infrastructure';
import { CatalogIntegrationService } from 'learner-activity/integration';
import { QUESTION_TYPE_MAP } from 'shared/constants';
import { Result } from 'shared/helpers/result';

// TODO: Remove the console.logs
@Injectable()
export class LearnerStatisticsService {
  constructor(
    private readonly learnerStatisticsRepository: LearnerStatisticsRepository,
    private readonly catalogIntegrationService: CatalogIntegrationService,
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
  ): Promise<Result<IncorrectlyAnsweredQuestion[]>> {
    try {
      const answers =
        await this.learnerStatisticsRepository.getCommonIncorrectlyAnsweredQuestionIds(
          learnerId,
        );
      const questionIds = answers.map((answer) => answer.questionId);
      const questions = await this.catalogIntegrationService.getQuestions({
        id: questionIds,
      });
      const incorrectlyAnsweredQuestions = questions.map((summary) => {
        const count =
          answers.find((it) => it.questionId === summary.id)?.count || 0;
        return new IncorrectlyAnsweredQuestion({
          id: summary.id,
          text: summary.text,
          deckId: summary.deck!.id,
          deckTitle: summary.deck!.title,
          count,
        });
      });
      return Result.success(incorrectlyAnsweredQuestions);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch most common wrong answers.`);
    }
  }

  async fetchQuestionTypeStatistics(
    learnerId: LearnerEvent['learnerId'],
  ): Promise<Result<QuestionTypeStatistics>> {
    try {
      const questionIds =
        await this.learnerStatisticsRepository.getAnsweredQuestionIds(
          learnerId,
        );
      const questions = await this.catalogIntegrationService.getQuestions({
        id: questionIds,
      });
      const multipleChoiceQuestions = questions.filter((question) => {
        return QUESTION_TYPE_MAP.multipleChoice === question.questionType.name;
      });
      const stats = new QuestionTypeStatistics({
        multipleChoiceCount: multipleChoiceQuestions.length,
        selfAssessmentCount: questions.length - multipleChoiceQuestions.length,
      });
      return Result.success(stats);
    } catch (error) {
      console.log(error);
      return Result.failure(`Failed to fetch question type statistics.`);
    }
  }
}
