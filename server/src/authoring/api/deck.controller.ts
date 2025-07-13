import {
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
} from '@nestjs/common';
import { Deck } from 'authoring/core/entities';
import { DeckService } from 'authoring/core/services';

@Controller('authoring/decks')
export class DeckController {
  constructor(private readonly deckService: DeckService) {}

  @Get(':id')
  async fetchById(@Param('id') deckId: Deck['id']): Promise<Deck> {
    const { error, data } = await this.deckService.fetchById(deckId);
    if (error || !data) throw new NotFoundException(error);
    return data;
  }

  @Delete(':id')
  async remove(@Param('id') deckId: Deck['id']): Promise<void> {
    const { error } = await this.deckService.remove(deckId);
    if (error) throw new NotFoundException(error);
  }
}
