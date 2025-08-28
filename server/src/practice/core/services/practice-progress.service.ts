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

  async fetch(
    learnerId: PracticeProgress['learnerId'],
    deckId?: PracticeProgress['deckId'],
  ): Promise<Result<PracticeProgress[]>> {
    try {
      const payload = { learnerId, deckId };
      const progress = await this.practiceProgressService.find(payload);
      return Result.success(progress);
    } catch {
      return Result.failure('Failed to fetch learner deck progress');
    }
  }
}
