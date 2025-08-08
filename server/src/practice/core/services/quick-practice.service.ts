import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { PracticeQuestion } from 'practice/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class QuickPracticeService {
  constructor(
    @InjectRepository(PracticeQuestion)
    private readonly practiceQuestionRepository: BaseEntityRepository<PracticeQuestion>,
  ) {}

  async fetchQuestions(
    deckId: PracticeQuestion['deckId'],
  ): Promise<Result<PracticeQuestion[]>> {
    try {
      const questions = await this.practiceQuestionRepository.find(
        { deckId },
        { populate: ['answerOptions'] },
      );
      return Result.success(questions);
    } catch {
      return Result.failure('Failed to fetch practice questions');
    }
  }
}
