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
import { User } from 'shared/auth/decorators';

// TODO: think about the endpoint naming convention
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

  // TODO: move to a separate controller
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

  // TODO: move to a separate controller
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
