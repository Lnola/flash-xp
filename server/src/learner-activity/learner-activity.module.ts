import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { CatalogExternalModule } from 'catalog/external';
import { LearnerStatisticsController } from './api';
import { LearnerEvent } from './core/entities';
import { AnswerSubmittedEventHandler } from './core/event-handlers';
import { LearnerEventService, LearnerStatisticsService } from './core/services';
import { LearnerStatisticsRepository } from './infrastructure';

@Module({
  imports: [MikroOrmModule.forFeature([LearnerEvent]), CatalogExternalModule],
  providers: [
    AnswerSubmittedEventHandler,
    LearnerEventService,
    LearnerStatisticsRepository,
    LearnerStatisticsService,
  ],
  controllers: [LearnerStatisticsController],
})
export class LearnerActivityModule {}
