import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { LearnerEvent } from './core/entities';
import { AnswerSubmittedEventHandler } from './core/event-handlers';
import { LearnerEventService, LearnerStatisticsService } from './core/services';
import { LearnerEventRepository } from './infrastructure';

@Module({
  imports: [MikroOrmModule.forFeature([LearnerEvent])],
  providers: [
    AnswerSubmittedEventHandler,
    LearnerEventService,
    LearnerEventRepository,
    LearnerStatisticsService,
  ],
  controllers: [],
})
export class LearnerActivityModule {}
