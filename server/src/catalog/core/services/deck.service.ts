import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { Deck } from '../entities/deck.entity';
import { EntityRepository } from '@mikro-orm/postgresql';

@Injectable()
export class DeckService {
  constructor(
    @InjectRepository(Deck)
    private readonly deckRepository: EntityRepository<Deck>,
  ) {}

  fetchAll() {
    return this.deckRepository.findAll();
  }
}
