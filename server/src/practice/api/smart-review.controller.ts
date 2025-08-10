import {
  BadRequestException,
  Controller,
  Get,
  Param,
  Post,
} from '@nestjs/common';
import { PracticeQuestion } from 'practice/core/entities';
import { SmartReviewService } from 'practice/core/services';
import { User } from 'shared/decorators';

@Controller('practice/smart')
export class SmartReviewController {
  constructor(private readonly smartReviewService: SmartReviewService) {}

  @Post('decks/:deckId/start')
  async start(
    @Param('deckId') deckId: PracticeQuestion['deckId'],
    @User('id') learnerId: number,
  ): Promise<void> {
    const { error } = await this.smartReviewService.initBoxes(
      deckId,
      learnerId,
    );
    if (error) throw new BadRequestException(error);
  }

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
