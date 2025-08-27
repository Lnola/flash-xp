import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { CatalogQuestion } from 'catalog/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class CatalogQuestionService {
  constructor(
    @InjectRepository(CatalogQuestion)
    private readonly catalogQuestionRepository: BaseEntityRepository<CatalogQuestion>,
  ) {}

  async fetchSummaries(
    ids: Array<CatalogQuestion['id']>,
  ): Promise<Result<CatalogQuestion[]>> {
    try {
      const questions = await this.catalogQuestionRepository.find(ids, {
        populate: ['deck'],
      });
      if (!questions || questions.length === 0) {
        return Result.failure('Questions not found');
      }
      return Result.success(questions);
    } catch {
      return Result.failure(`Failed to fetch summaries for the questions.`);
    }
  }
}
