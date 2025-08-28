import { Injectable } from '@nestjs/common';
import { PracticeExternalService } from 'practice/external';

@Injectable()
export class PracticeIntegrationService {
  constructor(
    private readonly practiceExternalService: PracticeExternalService,
  ) {}

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

type GetProgressByLearnerPayload = number;
type GetProgressByLearnerResult = PracticeProgress[];
