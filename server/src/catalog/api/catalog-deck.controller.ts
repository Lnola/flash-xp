import { Controller, Get, Param, Query } from '@nestjs/common';
import { CatalogDeck, Learner } from 'catalog/core/entities';
import { CatalogDeckService } from 'catalog/core/services';
import { User } from 'shared/decorators';
import { ZodValidationPipe } from 'shared/pipes';
import {
  CatalogDeckQuery,
  catalogDeckQuerySchema,
  parseCatalogDeckQuery,
} from './validators';

// TODO: Think about this controller name, structure and contents
@Controller('decks')
export class CatalogDeckController {
  constructor(private readonly catalogDeckService: CatalogDeckService) {}

  @Get()
  fetch(
    @Query(new ZodValidationPipe(catalogDeckQuerySchema))
    query: CatalogDeckQuery,
    @User('id') learnerId: Learner['id'],
  ) {
    const { where, pagination } = parseCatalogDeckQuery(query, learnerId);
    return this.catalogDeckService.fetch(where, pagination);
  }

  @Get(':id')
  fetchById(
    @Param('id') deckId: CatalogDeck['id'],
    @User('id') learnerId: Learner['id'],
  ) {
    return this.catalogDeckService.fetchById(deckId, learnerId);
  }
}
