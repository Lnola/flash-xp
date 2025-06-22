import { Controller, Get } from '@nestjs/common';
import { DeckService } from 'catalog/core/services/deck.service';

@Controller('decks')
export class DeckController {
  constructor(private readonly deckService: DeckService) {}

  @Get()
  fetchAll() {
    return this.deckService.fetchAll();
  }
}
