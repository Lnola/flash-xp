import { ObjectQuery } from '@mikro-orm/core';
import { Injectable } from '@nestjs/common';
import { CatalogQuestion } from 'catalog/core/entities';
import { CatalogQuestionService } from 'catalog/core/services';
import { Result } from 'shared/helpers/result';

@Injectable()
export class CatalogExternalService {
  constructor(
    private readonly catalogQuestionService: CatalogQuestionService,
  ) {}

  async fetch(
    where: ObjectQuery<CatalogQuestion>,
  ): Promise<Result<CatalogQuestion[]>> {
    return this.catalogQuestionService.fetch(where);
  }
}
