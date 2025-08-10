import { EntityManager } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
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
      const questions = await this.practiceQuestionRepository.find({ deckId });
      const boxes = questions.map((question) => {
        return new Box({ deckId, learnerId, question });
      });
      await this.boxRepository.persistAndFlush(boxes);
      return Result.success();
    } catch {
      return Result.failure('Failed to initialize smart review');
    }
  }

  //   TODO: implement the smart review logic
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
        return Result.failure('No questions found for this deck');
      }
      return Result.success(questions);
    } catch {
      return Result.failure('Failed to fetch practice questions');
    }
  }
}
