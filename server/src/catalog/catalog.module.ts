import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { DeckController } from './api/deck.controller';
import { Deck } from './core/entities/deck.entity';
import { DeckService } from './core/services/deck.service';

@Module({
  imports: [MikroOrmModule.forFeature([Deck])],
  providers: [DeckService],
  controllers: [DeckController],
})
export class CatalogModule {}
