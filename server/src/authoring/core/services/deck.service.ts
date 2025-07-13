import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { Author, Deck } from 'authoring/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class DeckService {
  constructor(
    @InjectRepository(Deck)
    private readonly deckRepository: BaseEntityRepository<Deck>,
  ) {}

  async fetchById(deckId: Deck['id']): Promise<Result<Deck>> {
    const deck = await this.deckRepository.findOne(deckId, {
      populate: ['questions', 'questions.answerOptions'],
    });
    if (!deck) return Result.failure('Deck not found');
    return Result.success(deck);
  }

  async fork(
    deckId: Deck['id'],
    authorId: Author['id'],
  ): Promise<Result<Deck>> {
    const originalDeck = await this.deckRepository.findOne(deckId, {
      populate: ['questions', 'questions.answerOptions'],
    });
    if (!originalDeck) return Result.failure('Original deck not found');
    if (originalDeck.authorId === authorId) {
      return Result.failure('Cannot fork your own deck');
    }
    const forkedDeck = originalDeck.fork(authorId);
    await this.deckRepository.persistAndFlush(forkedDeck);
    return Result.success(forkedDeck);
  }

  async remove(deckId: Deck['id']): Promise<Result<void>> {
    const deck = await this.deckRepository.findOne(deckId);
    if (!deck) return Result.failure('Deck not found');
    await this.deckRepository.removeAndFlush(deck);
    return Result.success();
  }
}
