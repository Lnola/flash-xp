import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
} from '@nestjs/common';
import { Author, Deck } from 'authoring/core/entities';
import { DeckService } from 'authoring/core/services';
import { User } from 'shared/auth/decorators';
import { CreateDeckDto } from './dto';

@Controller('authoring/decks')
export class DeckController {
  constructor(private readonly deckService: DeckService) {}

  @Get(':id')
  async fetchById(@Param('id') deckId: Deck['id']): Promise<Deck> {
    const { error, data } = await this.deckService.fetchById(deckId);
    if (error || !data) throw new NotFoundException(error);
    return data;
  }

  // TODO: Add prop validation
  @Post()
  async create(
    @User('id') authorId: Author['id'],
    @Body() createDeckDto: CreateDeckDto,
  ): Promise<Deck> {
    const { error, data } = await this.deckService.create(
      authorId,
      createDeckDto,
    );
    if (error || !data) throw new BadRequestException(error);
    return data;
  }

  @Post(':id/fork')
  async fork(
    @Param('id') deckId: Deck['id'],
    @User('id') authorId: Author['id'],
  ): Promise<Deck> {
    const { error, data } = await this.deckService.fork(deckId, authorId);
    if (error || !data) throw new BadRequestException(error);
    return data;
  }

  @Delete(':id')
  async remove(@Param('id') deckId: Deck['id']): Promise<void> {
    const { error } = await this.deckService.remove(deckId);
    if (error) throw new NotFoundException(error);
  }
}
