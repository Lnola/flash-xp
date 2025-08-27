import { Injectable } from '@nestjs/common';
import { CatalogExternalService } from 'catalog/external';

export type QuestionSummary = { id: number; text: string };

@Injectable()
export class CatalogIntegrationService {
  constructor(
    private readonly catalogExternalService: CatalogExternalService,
  ) {}

  async getQuestionSummaries(ids: number[]): Promise<QuestionSummary[]> {
    if (!ids.length) throw new Error('No IDs provided');
    const where = { id: { $in: ids } };
    const { error, data } = await this.catalogExternalService.fetch(where);
    if (error) throw new Error(error);
    return data!;
  }
}
