import { Injectable } from '@nestjs/common';
import { CatalogQuestion } from 'catalog/core/entities';
import { CatalogQuestionService } from 'catalog/core/services';
import { Result } from 'shared/helpers/result';

@Injectable()
export class CatalogExternalService {
  constructor(
    private readonly catalogQuestionService: CatalogQuestionService,
  ) {}

  async fetchSummaries(
    ids: Array<CatalogQuestion['id']>,
  ): Promise<Result<CatalogQuestion[]>> {
    return this.catalogQuestionService.fetchSummaries(ids);
  }
}
