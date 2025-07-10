import { Controller, Get, Param } from '@nestjs/common';
import { CatalogDeckService } from 'catalog/core/services/catalog-deck.service';

// TODO: think about the endpoint naming convention
@Controller('decks')
export class CatalogDeckController {
  constructor(private readonly catalogDeckService: CatalogDeckService) {}

  @Get()
  fetchAll() {
    return this.catalogDeckService.fetchAll();
  }

  @Get(':id')
  fetchById(@Param('id') id: number) {
    return this.catalogDeckService.fetchById(id);
  }
}
