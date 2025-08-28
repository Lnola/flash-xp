import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { BookmarkController, CatalogDeckController } from './api';
import { Bookmark, CatalogDeck, CatalogQuestion } from './core/entities';
import {
  BookmarkService,
  CatalogDeckService,
  CatalogQuestionService,
} from './core/services';
import { PracticeIntegrationModule } from './integration';

@Module({
  imports: [
    MikroOrmModule.forFeature([Bookmark, CatalogDeck, CatalogQuestion]),
    PracticeIntegrationModule,
  ],
  providers: [BookmarkService, CatalogDeckService, CatalogQuestionService],
  controllers: [BookmarkController, CatalogDeckController],
  exports: [CatalogQuestionService],
})
export class CatalogModule {}
