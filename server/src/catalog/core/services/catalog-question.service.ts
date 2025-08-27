import { ObjectQuery } from '@mikro-orm/core';
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

  async fetch(
    where: ObjectQuery<CatalogQuestion>,
  ): Promise<Result<CatalogQuestion[]>> {
    try {
      const questions = await this.catalogQuestionRepository.find(where, {
        populate: ['deck'],
      });
      if (!questions || questions.length === 0) {
        return Result.failure('Questions not found');
      }
      return Result.success(questions);
    } catch {
      return Result.failure(`Failed to fetch the questions.`);
    }
  }
}
