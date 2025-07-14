import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { DeckController } from './api';
import { Deck, QuestionType } from './core/entities';
import { DeckService } from './core/services';

@Module({
  imports: [MikroOrmModule.forFeature([Deck, QuestionType])],
  providers: [DeckService],
  controllers: [DeckController],
})
export class AuthoringModule {}
