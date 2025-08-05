import {
  BadRequestException,
  Body,
  ConflictException,
  Controller,
  Delete,
  Param,
  Post,
} from '@nestjs/common';
import { CatalogDeck, Learner } from 'catalog/core/entities';
import { BookmarkService } from 'catalog/core/services';
import { User } from 'shared/decorators';

@Controller('catalog/bookmarks')
export class BookmarkController {
  constructor(private readonly bookmarkService: BookmarkService) {}

  @Post(':deckId')
  async createBookmark(
    @Param('deckId') deckId: CatalogDeck['id'],
    @User('id') learnerId: Learner['id'],
  ): Promise<void> {
    const { error } = await this.bookmarkService.createBookmark(
      deckId,
      learnerId,
    );
    if (error) throw new ConflictException(error);
  }

  @Delete(':deckId')
  async deleteBookmark(
    @Param('deckId') deckId: CatalogDeck['id'],
    @User('id') learnerId: Learner['id'],
  ): Promise<void> {
    const { error } = await this.bookmarkService.deleteBookmark(
      deckId,
      learnerId,
    );
    if (error) throw new BadRequestException(error);
  }
}
