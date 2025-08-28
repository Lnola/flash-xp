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
import { QUESTION_TYPE_MAP, QuestionTypeName } from 'shared/constants';
import { Result } from 'shared/helpers/result';

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
    } catch {
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
    } catch {
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
    } catch {
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
    } catch {
      return Result.failure(`Failed to fetch daily correct/incorrect answers.`);
    }
  }

  // Question type accuracy rate can be extracted as a separate query but that would require
  // introduction of LearnerActivityQuestion and LearnerActivityQuestionType entities.
  // If performance is a big concern and adding new entities would be costly,
  // an alternative would be to implement the repository without the entity mapping;
  // treating it as raw SQL in the repository without ORM mapping the models being interacted with.
  async fetchAccuracyRate(
    learnerId: LearnerEvent['learnerId'],
    questionType?: QuestionTypeName,
  ): Promise<Result<AccuracyRate>> {
    try {
      let questionIds: number[] | undefined;
      if (questionType) {
        const payload = { questionType: { name: questionType } };
        const questionsOfType =
          await this.catalogIntegrationService.getQuestions(payload);
        questionIds = questionsOfType.map((question) => question.id);
      }
      const accuracyRate =
        await this.learnerStatisticsRepository.getAccuracyRate(
          learnerId,
          questionIds,
        );
      return Result.success(accuracyRate);
    } catch {
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
      if (!answers.length) return Result.success([]);
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
    } catch {
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
      if (!questionIds.length)
        return Result.success(
          new QuestionTypeStatistics({
            multipleChoiceCount: 0,
            selfAssessmentCount: 0,
          }),
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
    } catch {
      return Result.failure(`Failed to fetch question type statistics.`);
    }
  }
}
