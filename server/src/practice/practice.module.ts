import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { QuickPracticeController, SmartReviewController } from './api';
import { Box, PracticeProgress, PracticeQuestion } from './core/entities';
import {
  BoxService,
  PracticeAnalyticsService,
  PracticeProgressService,
  QuickPracticeService,
  SmartReviewService,
} from './core/services';
import { BoxRepository, PracticeQuestionRepository } from './infrastructure';

@Module({
  imports: [
    MikroOrmModule.forFeature([Box, PracticeQuestion, PracticeProgress]),
  ],
  providers: [
    QuickPracticeService,
    SmartReviewService,
    BoxService,
    PracticeProgressService,
    PracticeAnalyticsService,
    BoxRepository,
    PracticeQuestionRepository,
  ],
  controllers: [QuickPracticeController, SmartReviewController],
  exports: [BoxService, PracticeProgressService, PracticeAnalyticsService],
})
export class PracticeModule {}
