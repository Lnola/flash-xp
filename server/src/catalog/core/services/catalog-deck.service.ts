import { UniqueConstraintViolationException } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { Bookmark, CatalogDeck, Learner } from 'catalog/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class CatalogDeckService {
  constructor(
    @InjectRepository(CatalogDeck)
    private readonly catalogDeckRepository: BaseEntityRepository<CatalogDeck>,
    @InjectRepository(Bookmark)
    private readonly bookmarkRepository: BaseEntityRepository<Bookmark>,
  ) {}

  fetchAll() {
    return this.catalogDeckRepository.findAll();
  }

  // TODO: implement this correctly
  async fetchById(
    deckId: CatalogDeck['id'],
    learnerId: Learner['id'],
  ): Promise<
    | (CatalogDeck & {
        isCurrentUserAuthor: boolean;
        isBookmarked: boolean;
      })
    | null
  > {
    const deck = await this.catalogDeckRepository.findOne(deckId, {
      populate: ['questions'],
    });
    if (!deck) {
      return null;
    }
    const deckBookmarkByCurrentUser = await this.bookmarkRepository.findOne({
      deckId,
      learnerId,
    });
    return {
      ...deck,
      isCurrentUserAuthor: true,
      isBookmarked: !!deckBookmarkByCurrentUser,
    };
  }

  async createBookmark(
    deckId: CatalogDeck['id'],
    learnerId: Learner['id'],
  ): Promise<Result<void>> {
    try {
      const bookmark = new Bookmark(deckId, learnerId);
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
    const bookmarkToRemove = await this.bookmarkRepository.findOne({
      deckId: deckId,
      learnerId: learnerId,
    });
    if (!bookmarkToRemove) return Result.failure('Bookmark does not exist');
    await this.bookmarkRepository.removeAndFlush(bookmarkToRemove);
    return Result.success();
  }
}
