import { Controller, Get, Param } from '@nestjs/common';
import { CatalogDeck } from 'catalog/core/entities';
import { CatalogDeckService } from 'catalog/core/services';

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
}
