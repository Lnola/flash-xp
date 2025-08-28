import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { PracticeProgress } from 'practice/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class PracticeProgressService {
  constructor(
    @InjectRepository(PracticeProgress)
    private readonly practiceProgressService: BaseEntityRepository<PracticeProgress>,
  ) {}

  async fetchInProgressDecks(
    learnerId: PracticeProgress['learnerId'],
  ): Promise<Result<PracticeProgress[]>> {
    try {
      const payload = { learnerId };
      const progress = await this.practiceProgressService.find(payload);
      return Result.success(progress);
    } catch {
      return Result.failure('Failed to fetch learner deck progress');
    }
  }
}
