import { Injectable } from '@nestjs/common';
import { PracticeExternalService } from 'practice/external';

@Injectable()
export class PracticeIntegrationService {
  constructor(
    private readonly practiceExternalService: PracticeExternalService,
  ) {}

  async getProgress({
    learnerId,
    deckId,
  }: GetProgressPayload): Promise<GetProgressResult> {
    const { error, data } = await this.practiceExternalService.fetchProgress(
      learnerId,
      deckId,
    );
    if (error) throw new Error(error);
    return data!;
  }

  async getProgressByLearner(
    payload: GetProgressByLearnerPayload,
  ): Promise<GetProgressByLearnerResult> {
    const { error, data } =
      await this.practiceExternalService.fetchProgressByLearner(payload);
    if (error) throw new Error(error);
    return data!;
  }
}

type PracticeProgress = {
  deckId: number;
  learnerId: number;
  progress: number;
};

type GetProgressPayload = {
  learnerId: number;
  deckId: number;
};
type GetProgressResult = PracticeProgress[];

type GetProgressByLearnerPayload = number;
type GetProgressByLearnerResult = PracticeProgress[];

export type CatalogPracticeProgress = PracticeProgress;
