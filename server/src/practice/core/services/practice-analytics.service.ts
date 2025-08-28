import { Injectable } from '@nestjs/common';
import { BoxRepository } from 'practice/infrastructure';
import { Result } from 'shared/helpers/result';

@Injectable()
export class PracticeAnalyticsService {
  constructor(private readonly boxRepository: BoxRepository) {}

  async fetchPopularDeckIds(): Promise<Result<number[]>> {
    try {
      const deckIds = await this.boxRepository.findPopularDeckIds();
      return Result.success(deckIds);
    } catch {
      return Result.failure('Failed to fetch learner deck progress');
    }
  }
}
