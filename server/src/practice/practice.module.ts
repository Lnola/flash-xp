import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { QuickPracticeController, SmartReviewController } from './api';
import { Box, PracticeProgress, PracticeQuestion } from './core/entities';
import { QuickPracticeService, SmartReviewService } from './core/services';
import { PracticeQuestionRepository } from './infrastructure';

@Module({
  imports: [
    MikroOrmModule.forFeature([Box, PracticeQuestion, PracticeProgress]),
  ],
  providers: [
    QuickPracticeService,
    SmartReviewService,
    PracticeQuestionRepository,
  ],
  controllers: [QuickPracticeController, SmartReviewController],
})
export class PracticeModule {}
