import { Body, Controller, Delete, Get, Param, Post } from '@nestjs/common';
import { CatalogDeck } from 'catalog/core/entities';
import { CatalogDeckService } from 'catalog/core/services';
import { CreateBookmarkDto, DeleteBookmarkDto } from './dto';

// TODO: think about the endpoint naming convention
@Controller('decks')
export class CatalogDeckController {
  constructor(private readonly catalogDeckService: CatalogDeckService) {}

  @Get()
  fetchAll() {
    return this.catalogDeckService.fetchAll();
  }

  @Get(':id')
  fetchById(@Param('id') deckId: CatalogDeck['id']) {
    return this.catalogDeckService.fetchById(deckId);
  }

  // TODO: move to a separate controller
  @Post('bookmarks')
  createBookmark(@Body() { deckId, learnerId }: CreateBookmarkDto) {
    return this.catalogDeckService.createBookmark(deckId, learnerId);
  }

  // TODO: move to a separate controller
  @Delete('bookmarks')
  deleteBookmark(@Body() { deckId, learnerId }: DeleteBookmarkDto) {
    return this.catalogDeckService.deleteBookmark(deckId, learnerId);
  }
}
