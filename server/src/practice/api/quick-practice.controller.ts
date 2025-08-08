import { BadRequestException, Controller, Get, Param } from '@nestjs/common';
import { PracticeQuestion } from 'practice/core/entities';
import { QuickPracticeService } from 'practice/core/services';

@Controller('practice/quick')
export class QuickPracticeController {
  constructor(private readonly quickPracticeService: QuickPracticeService) {}

  @Get('decks/:deckId/questions')
  async fetchQuestions(
    @Param('deckId') deckId: PracticeQuestion['deckId'],
  ): Promise<PracticeQuestion[]> {
    const { error, data } =
      await this.quickPracticeService.fetchQuestions(deckId);
    if (error || !data) throw new BadRequestException(error);
    return data;
  }
}
