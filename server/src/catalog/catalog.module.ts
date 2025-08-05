import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { BookmarkController, CatalogDeckController } from './api';
import { Bookmark, CatalogDeck } from './core/entities';
import { BookmarkService, CatalogDeckService } from './core/services';

@Module({
  imports: [MikroOrmModule.forFeature([Bookmark, CatalogDeck])],
  providers: [BookmarkService, CatalogDeckService],
  controllers: [BookmarkController, CatalogDeckController],
})
export class CatalogModule {}
