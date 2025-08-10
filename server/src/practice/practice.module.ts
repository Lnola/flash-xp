import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { QuickPracticeController, SmartReviewController } from './api';
import { Box, PracticeQuestion } from './core/entities';
import { QuickPracticeService, SmartReviewService } from './core/services';

@Module({
  imports: [MikroOrmModule.forFeature([Box, PracticeQuestion])],
  providers: [QuickPracticeService, SmartReviewService],
  controllers: [QuickPracticeController, SmartReviewController],
})
export class PracticeModule {}
