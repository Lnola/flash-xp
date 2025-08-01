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
  fetchById(
    @Param('id') deckId: CatalogDeck['id'],
    @User('id') learnerId: Learner['id'],
  ) {
    return this.catalogDeckService.fetchById(deckId, learnerId);
  }

  // TODO: move to a separate controller
  @Post('bookmarks')
  async createBookmark(
    @Body() { deckId, learnerId }: CreateBookmarkDto,
  ): Promise<void> {
    const { error } = await this.catalogDeckService.createBookmark(
      deckId,
      learnerId,
    );
    if (error) throw new ConflictException(error);
  }

  // TODO: move to a separate controller
  @Delete('bookmarks')
  async deleteBookmark(
    @Body() { deckId, learnerId }: DeleteBookmarkDto,
  ): Promise<void> {
    const { error } = await this.catalogDeckService.deleteBookmark(
      deckId,
      learnerId,
    );
    if (error) throw new BadRequestException(error);
  }
}
