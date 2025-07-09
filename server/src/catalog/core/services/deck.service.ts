import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Injectable } from '@nestjs/common';
import { Deck } from 'catalog/core/entities';

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
