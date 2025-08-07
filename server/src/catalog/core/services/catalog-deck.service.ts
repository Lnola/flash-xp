import { ObjectQuery } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { CatalogDeckPreview } from 'catalog/api/dto';
import { CatalogDeck, Learner } from 'catalog/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { ParseQueryPagination } from 'shared/helpers/parse-query';
import { Result } from 'shared/helpers/result';

@Injectable()
export class CatalogDeckService {
  constructor(
    @InjectRepository(CatalogDeck)
    private readonly catalogDeckRepository: BaseEntityRepository<CatalogDeck>,
  ) {}

  async fetch(
    where: ObjectQuery<CatalogDeck>,
    pagination: ParseQueryPagination,
  ): Promise<Result<CatalogDeck[]>> {
    try {
      const decks = await this.catalogDeckRepository.find(where, {
        ...pagination,
      });
      return Result.success(decks);
    } catch {
      return Result.failure(`Failed to fetch decks.`);
    }
  }

  async fetchById(
    deckId: CatalogDeck['id'],
    learnerId: Learner['id'],
  ): Promise<Result<CatalogDeckPreview>> {
    try {
      const deck = await this.catalogDeckRepository.findOne(deckId, {
        populate: ['questions', 'bookmarks'],
      });
      if (!deck) return Result.failure('Deck not found');
      const previewDeck = this._mapCatalogDeckForPreview(deck, learnerId);
      return Result.success(previewDeck);
    } catch {
      return Result.failure(`Failed to fetch deck.`);
    }
  }

  _mapCatalogDeckForPreview(
    deck: CatalogDeck,
    learnerId: Learner['id'],
  ): CatalogDeckPreview {
    return {
      ...deck,
      isBookmarked: deck.isBookmarkedByLearner(learnerId),
      isCurrentUserAuthor: deck.authorId === learnerId,
    };
  }
}
