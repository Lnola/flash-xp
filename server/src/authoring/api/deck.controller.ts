import { Controller } from '@nestjs/common';
import { DeckService } from 'authoring/core/services';

@Controller('authoring/decks')
export class DeckController {
  constructor(private readonly deckService: DeckService) {}
}
