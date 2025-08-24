import {
  BadRequestException,
  Body,
  Controller,
  Get,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { PracticeQuestion } from 'practice/core/entities';
import { SmartReviewService } from 'practice/core/services';
import { User } from 'shared/decorators';

@Controller('practice/smart')
export class SmartReviewController {
  constructor(private readonly smartReviewService: SmartReviewService) {}

  @Post('decks/:deckId/boxes')
  async initBoxes(
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

  @Put('decks/:deckId/boxes/:questionId')
  async submitAnswer(
    @Param('questionId') questionId: PracticeQuestion['id'],
    @User('id') learnerId: number,
    @Body('isCorrect') isCorrect: boolean,
  ): Promise<void> {
    const { error } = await this.smartReviewService.submitAnswer(
      +questionId,
      learnerId,
      isCorrect,
    );
    if (error) throw new BadRequestException(error);
  }
}
