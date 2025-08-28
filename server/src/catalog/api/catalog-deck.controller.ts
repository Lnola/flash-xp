import {
  BadRequestException,
  Controller,
  Get,
  Param,
  Query,
} from '@nestjs/common';
import { CatalogDeck, Learner } from 'catalog/core/entities';
import { CatalogDeckService } from 'catalog/core/services';
import { User } from 'shared/decorators';
import { ZodValidationPipe } from 'shared/pipes';
import { CatalogDeckPreview } from './dto';
import {
  CatalogDeckQuery,
  catalogDeckQuerySchema,
  parseCatalogDeckQuery,
} from './validators';

@Controller('catalog/decks')
export class CatalogDeckController {
  constructor(private readonly catalogDeckService: CatalogDeckService) {}

  @Get()
  async fetch(
    @Query(new ZodValidationPipe(catalogDeckQuerySchema))
    query: CatalogDeckQuery,
    @User('id') learnerId: Learner['id'],
  ): Promise<CatalogDeck[]> {
    const { where, pagination } = parseCatalogDeckQuery(query, learnerId);
    const { error, data } = await this.catalogDeckService.fetch(
      learnerId,
      where,
      pagination,
    );
    if (error || !data) throw new BadRequestException(error);
    return data;
  }

  @Get('in-progress')
  async fetchInProgress(
    @User('id') learnerId: Learner['id'],
  ): Promise<CatalogDeck[]> {
    const { error, data } =
      await this.catalogDeckService.fetchInProgress(learnerId);
    if (error || !data) throw new BadRequestException(error);
    return data;
  }

  @Get(':id')
  async fetchById(
    @Param('id') deckId: CatalogDeck['id'],
    @User('id') learnerId: Learner['id'],
  ): Promise<CatalogDeckPreview> {
    const { error, data } = await this.catalogDeckService.fetchById(
      deckId,
      learnerId,
    );
    if (error || !data) throw new BadRequestException(error);
    return data;
  }
}
