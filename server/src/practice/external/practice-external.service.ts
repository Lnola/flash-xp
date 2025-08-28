import { Injectable } from '@nestjs/common';
import { PracticeProgress } from 'practice/core/entities';
import { PracticeProgressService } from 'practice/core/services';
import { Result } from 'shared/helpers/result';

@Injectable()
export class PracticeExternalService {
  constructor(
    private readonly practiceProgressService: PracticeProgressService,
  ) {}

  async fetchInProgressDecksProgress(
    learnerId: PracticeProgress['learnerId'],
  ): Promise<Result<PracticeProgress[]>> {
    return this.practiceProgressService.fetchInProgressDecksProgress(learnerId);
  }
}
