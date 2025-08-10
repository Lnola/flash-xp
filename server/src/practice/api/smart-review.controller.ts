import { BadRequestException, Controller, Get, Param } from '@nestjs/common';
import { PracticeQuestion } from 'practice/core/entities';
import { SmartReviewService } from 'practice/core/services';
import { User } from 'shared/decorators';

@Controller('practice/smart')
export class SmartReviewController {
  constructor(private readonly smartReviewService: SmartReviewService) {}

  @Get('decks/:deckId/questions')
  async fetchQuestions(
    @Param('deckId') deckId: PracticeQuestion['deckId'],
    @User('id') learnerId: number,
  ): Promise<PracticeQuestion[]> {
    const { error, data } = await this.smartReviewService.fetchQuestions(
      deckId,
      learnerId,
    );
    if (error || !data) throw new BadRequestException(error);
    return data;
  }
}
