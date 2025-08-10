import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { PracticeQuestion } from 'practice/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class SmartReviewService {
  constructor(
    @InjectRepository(PracticeQuestion)
    private readonly practiceQuestionRepository: BaseEntityRepository<PracticeQuestion>,
  ) {}

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
