import { UniqueConstraintViolationException } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { Bookmark, CatalogDeck, Learner } from 'catalog/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';

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

  fetchById(deckId: CatalogDeck['id']) {
    // TODO: add error handling
    return this.catalogDeckRepository.findOne(deckId, {
      populate: ['questions'],
    });
  }

  async createBookmark(
    deckId: CatalogDeck['id'],
    learnerId: Learner['id'],
  ): Promise<boolean> {
    try {
      const bookmark = new Bookmark(deckId, learnerId);
      await this.bookmarkRepository.persistAndFlush(bookmark);
      return true;
    } catch (error) {
      if (error instanceof UniqueConstraintViolationException) return false;
      throw error;
    }
  }

  async deleteBookmark(deckId: CatalogDeck['id'], learnerId: Learner['id']) {
    const bookmarkToRemove = await this.bookmarkRepository.findOne({
      deckId: deckId,
      learnerId: learnerId,
    });
    // TODO: add error handling
    if (!bookmarkToRemove) throw new Error(`Not found`);
    await this.bookmarkRepository.removeAndFlush(bookmarkToRemove);
  }
}
