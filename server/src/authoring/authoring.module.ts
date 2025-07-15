import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { DeckController } from './api';
import { Deck, QuestionType } from './core/entities';
import { QuestionTypeProvider } from './core/providers';
import { DeckService } from './core/services';

@Module({
  imports: [MikroOrmModule.forFeature([Deck, QuestionType])],
  providers: [QuestionTypeProvider, DeckService],
  controllers: [DeckController],
})
export class AuthoringModule {}
