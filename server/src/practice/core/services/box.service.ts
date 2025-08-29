import { Injectable } from '@nestjs/common';
import { Box } from 'practice/core/entities';
import { BoxRepository } from 'practice/infrastructure';
import { Result } from 'shared/helpers/result';

@Injectable()
// Possible name is also BoxQueryService or BoxReadService. In case logic becomes more complex
// renaming this service and separating reads and writes or logic may be a good idea.
export class BoxService {
  constructor(private readonly boxRepository: BoxRepository) {}

  async fetchBoxes(payload: FetchBoxesPayload): Promise<Result<Box[]>> {
    try {
      const boxes = await this.boxRepository.find(payload);
      return Result.success(boxes);
    } catch {
      return Result.failure('Failed to fetch boxes');
    }
  }
}

type FetchBoxesPayload = {
  learnerId: Box['learnerId'];
  deckId: Box['deckId'];
};
