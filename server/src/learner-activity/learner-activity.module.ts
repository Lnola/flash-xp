import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { AnswerSubmittedEventHandler } from './core/event-handlers';

@Module({
  imports: [MikroOrmModule.forFeature([])],
  providers: [AnswerSubmittedEventHandler],
  controllers: [],
})
export class LearnerActivityModule {}
