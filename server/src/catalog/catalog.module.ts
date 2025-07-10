import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { CatalogDeckController } from './api/catalog-deck.controller';
import { CatalogDeck } from './core/entities';
import { CatalogDeckService } from './core/services';

@Module({
  imports: [MikroOrmModule.forFeature([CatalogDeck])],
  providers: [CatalogDeckService],
  controllers: [CatalogDeckController],
})
export class CatalogModule {}
