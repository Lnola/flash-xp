import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { DeckController } from './api';
import { Deck } from './core/entities';
import { DeckService } from './core/services';

@Module({
  imports: [MikroOrmModule.forFeature([Deck])],
  providers: [DeckService],
  controllers: [DeckController],
})
export class AuthoringModule {}
