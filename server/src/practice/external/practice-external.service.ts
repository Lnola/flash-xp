import { Injectable } from '@nestjs/common';
import { Box, PracticeProgress } from 'practice/core/entities';
import {
  BoxService,
  PracticeAnalyticsService,
  PracticeProgressService,
} from 'practice/core/services';
import { Result } from 'shared/helpers/result';

@Injectable()
export class PracticeExternalService {
  constructor(
    private readonly boxService: BoxService,
    private readonly practiceProgressService: PracticeProgressService,
    private readonly practiceAnalyticsService: PracticeAnalyticsService,
  ) {}

  async fetchBoxes(payload: {
    learnerId: number;
    deckId: number;
  }): Promise<Result<Box[]>> {
    return this.boxService.fetchBoxes(payload);
  }

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

  async fetchPopularDeckIds(): Promise<Result<number[]>> {
    return this.practiceAnalyticsService.fetchPopularDeckIds();
  }
}
