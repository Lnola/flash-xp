import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  UseGuards,
} from '@nestjs/common';
import { Author, Deck } from 'authoring/core/entities';
import { DeckService } from 'authoring/core/services';
import { User, Deck as ExistingDeck } from 'shared/auth/decorators';
import { ZodValidationPipe } from 'shared/pipes';
import { CreateDeckDto, UpdateDeckDto } from './dto';
import { IsAuthorGuard } from './guards';
import { createDeckSchema, updateDeckSchema } from './validators';

// TODO: add guards to ensure only the author can do certain actions
@Controller('authoring/decks')
export class DeckController {
  constructor(private readonly deckService: DeckService) {}

  @UseGuards(IsAuthorGuard)
  @Get(':id')
  async fetchById(@ExistingDeck() existingDeck: Deck): Promise<Deck> {
    const { error, data } = await this.deckService.populate(existingDeck);
    if (error || !data) throw new NotFoundException(error);
    return data;
  }

  @Post()
  async create(
    @Body(new ZodValidationPipe(createDeckSchema)) createDeckDto: CreateDeckDto,
    @User('id') authorId: Author['id'],
  ): Promise<Deck> {
    const { error, data } = await this.deckService.create(
      authorId,
      createDeckDto,
    );
    if (error || !data) throw new BadRequestException(error);
    return data;
  }

  @Put(':id')
  async update(
    @Body(new ZodValidationPipe(updateDeckSchema)) updateDeckDto: UpdateDeckDto,
    @Param('id') deckId: Deck['id'],
    @User('id') authorId: Author['id'],
  ): Promise<Deck> {
    const { error, data } = await this.deckService.update(
      authorId,
      deckId,
      updateDeckDto,
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
