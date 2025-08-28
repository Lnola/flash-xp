import { Injectable } from '@nestjs/common';
import { PracticeProgress } from 'practice/core/entities';
import { PracticeProgressService } from 'practice/core/services';
import { Result } from 'shared/helpers/result';

@Injectable()
export class PracticeExternalService {
  constructor(
    private readonly practiceProgressService: PracticeProgressService,
  ) {}

  async fetchProgress(
    learnerId: PracticeProgress['learnerId'],
    deckId: PracticeProgress['deckId'],
  ): Promise<Result<PracticeProgress[]>> {
    return this.practiceProgressService.fetch(learnerId, deckId);
  }

  async fetchProgressByLearner(
    learnerId: PracticeProgress['learnerId'],
  ): Promise<Result<PracticeProgress[]>> {
    return this.practiceProgressService.fetch(learnerId);
  }
}
