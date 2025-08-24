import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { LearnerEvent } from './core/entities';
import { AnswerSubmittedEventHandler } from './core/event-handlers';

@Module({
  imports: [MikroOrmModule.forFeature([LearnerEvent])],
  providers: [AnswerSubmittedEventHandler],
  controllers: [],
})
export class LearnerActivityModule {}
