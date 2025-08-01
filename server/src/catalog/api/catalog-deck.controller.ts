import {
  BadRequestException,
  Body,
  ConflictException,
  Controller,
  Delete,
  Get,
  Param,
  Post,
} from '@nestjs/common';
import { CatalogDeck, Learner } from 'catalog/core/entities';
import { CatalogDeckService } from 'catalog/core/services';
import { User } from 'shared/decorators';

// TODO: Think about this controller name, structure and contents
@Controller('decks')
export class CatalogDeckController {
  constructor(private readonly catalogDeckService: CatalogDeckService) {}

  @Get()
  fetchAll() {
    return this.catalogDeckService.fetchAll();
  }

  @Get(':id')
  fetchById(
    @Param('id') deckId: CatalogDeck['id'],
    @User('id') learnerId: Learner['id'],
  ) {
    return this.catalogDeckService.fetchById(deckId, learnerId);
  }

  @Post(':deckId/bookmarks')
  async createBookmark(
    @Param('deckId') deckId: CatalogDeck['id'],
    @User('id') learnerId: Learner['id'],
  ): Promise<void> {
    const { error } = await this.catalogDeckService.createBookmark(
      deckId,
      learnerId,
    );
    if (error) throw new ConflictException(error);
  }

  @Delete(':deckId/bookmarks')
  async deleteBookmark(
    @Param('deckId') deckId: CatalogDeck['id'],
    @User('id') learnerId: Learner['id'],
  ): Promise<void> {
    const { error } = await this.catalogDeckService.deleteBookmark(
      deckId,
      learnerId,
    );
    if (error) throw new BadRequestException(error);
  }
}
