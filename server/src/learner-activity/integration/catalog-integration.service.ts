import { Injectable } from '@nestjs/common';
import { CatalogExternalService } from 'catalog/external';

@Injectable()
export class CatalogIntegrationService {
  constructor(
    private readonly catalogExternalService: CatalogExternalService,
  ) {}

  async getQuestions(
    payload: GetQuestionsPayload,
  ): Promise<GetQuestionsResult> {
    const { error, data } =
      await this.catalogExternalService.fetchQuestions(payload);
    if (error) throw new Error(error);
    return data!;
  }
}

type Question = {
  id: number;
  text: string;
  deck?: {
    id: number;
    title: string;
  };
};

type GetQuestionsPayload = {
  id: number | number[];
};
type GetQuestionsResult = Question[];
