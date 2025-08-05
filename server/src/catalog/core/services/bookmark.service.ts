import {
  EntityManager,
  UniqueConstraintViolationException,
} from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { Bookmark, CatalogDeck, Learner } from 'catalog/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class BookmarkService {
  constructor(
    private readonly em: EntityManager,
    @InjectRepository(Bookmark)
    private readonly bookmarkRepository: BaseEntityRepository<Bookmark>,
  ) {}

  async createBookmark(
    deckId: CatalogDeck['id'],
    learnerId: Learner['id'],
  ): Promise<Result<void>> {
    try {
      const deck = this.em.getReference(CatalogDeck, deckId);
      const bookmark = new Bookmark(deck, learnerId);
      await this.bookmarkRepository.persistAndFlush(bookmark);
      return Result.success();
    } catch (error) {
      if (error instanceof UniqueConstraintViolationException) {
        return Result.failure('Bookmark already exists');
      }
      throw error;
    }
  }

  async deleteBookmark(
    deckId: CatalogDeck['id'],
    learnerId: Learner['id'],
  ): Promise<Result<void>> {
    const deck = this.em.getReference(CatalogDeck, deckId);
    const bookmarkToRemove = await this.bookmarkRepository.findOne({
      deck,
      learnerId,
    });
    if (!bookmarkToRemove) return Result.failure('Bookmark does not exist');
    await this.bookmarkRepository.removeAndFlush(bookmarkToRemove);
    return Result.success();
  }
}
