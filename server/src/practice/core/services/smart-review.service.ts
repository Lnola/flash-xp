import { UniqueConstraintViolationException } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityManager } from '@mikro-orm/postgresql';
import { Injectable } from '@nestjs/common';
import { Box, PracticeQuestion } from 'practice/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class SmartReviewService {
  constructor(
    private readonly em: EntityManager,
    @InjectRepository(Box)
    private readonly boxRepository: BaseEntityRepository<Box>,
    @InjectRepository(PracticeQuestion)
    private readonly practiceQuestionRepository: BaseEntityRepository<PracticeQuestion>,
  ) {}

  async initBoxes(
    deckId: PracticeQuestion['deckId'],
    learnerId: number,
  ): Promise<Result<void>> {
    try {
      // TODO: move this logic to a repository
      const knex = this.em.getKnex();
      const boxIdsSubquery = knex('box')
        .select(1)
        .where('box.question_id', knex.ref('question.id'))
        .andWhere('box.learner_id', learnerId);
      const rows = await knex('question')
        .select('*')
        .where('question.deck_id', deckId)
        .whereNotExists(boxIdsSubquery);
      if (rows.length === 0) return Result.success();
      const questionsWithNoBoxes = rows.map((q: PracticeQuestion) =>
        this.practiceQuestionRepository.map(q),
      );
      const boxes = questionsWithNoBoxes.map(
        (question) => new Box({ deckId, learnerId, question }),
      );
      await this.boxRepository.persistAndFlush(boxes);
      return Result.success();
    } catch (error) {
      if (error instanceof UniqueConstraintViolationException) {
        return Result.success();
      }
      return Result.failure('Failed to initialize smart review');
    }
  }

  async fetchQuestions(
    deckId: PracticeQuestion['deckId'],
    learnerId: number,
  ): Promise<Result<PracticeQuestion[]>> {
    try {
      const questions = await this.practiceQuestionRepository.find(
        { boxes: { deckId, learnerId, availableFrom: { $lte: new Date() } } },
        { populate: ['answerOptions'] },
      );
      if (questions.length === 0) {
        return Result.failure(
          'No questions are available for smart review at this time.',
        );
      }
      return Result.success(questions);
    } catch {
      return Result.failure('Failed to fetch practice questions');
    }
  }

  async submitAnswer(
    questionId: PracticeQuestion['id'],
    learnerId: number,
    isCorrect: boolean,
  ): Promise<Result<void>> {
    if (!isCorrect) return Result.success();
    try {
      const box = await this.boxRepository.findOne({
        question: questionId,
        learnerId,
      });
      if (!box) return Result.failure('Box not found');
      box.incrementBox();
      await this.boxRepository.persistAndFlush(box);
      return Result.success();
    } catch {
      return Result.failure('Failed to increment box');
    }
  }
}
