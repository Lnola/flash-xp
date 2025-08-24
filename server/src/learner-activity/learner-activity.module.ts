import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { LearnerEvent } from './core/entities';
import { AnswerSubmittedEventHandler } from './core/event-handlers';
import { LearnerEventService } from './core/services';

@Module({
  imports: [MikroOrmModule.forFeature([LearnerEvent])],
  providers: [AnswerSubmittedEventHandler, LearnerEventService],
  controllers: [],
})
export class LearnerActivityModule {}
