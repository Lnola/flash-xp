import { Controller, Get } from '@nestjs/common';
import { CatalogDeckService } from 'catalog/core/services/catalog-deck.service';

// TODO: think about the endpoint naming convention
@Controller('decks')
export class CatalogDeckController {
  constructor(private readonly catalogDeckService: CatalogDeckService) {}

  @Get()
  fetchAll() {
    return this.catalogDeckService.fetchAll();
  }
}
