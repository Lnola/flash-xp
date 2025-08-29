import { ObjectQuery, QueryOrder } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { CatalogDeckPreview } from 'catalog/api/dto';
import { CatalogDeck, Learner } from 'catalog/core/entities';
import {
  CatalogPracticeProgress,
  PracticeIntegrationService,
} from 'catalog/integration';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { ParseQueryPagination } from 'shared/helpers/parse-query';
import { Result } from 'shared/helpers/result';

@Injectable()
export class CatalogDeckService {
  constructor(
    @InjectRepository(CatalogDeck)
    private readonly catalogDeckRepository: BaseEntityRepository<CatalogDeck>,
    private readonly practiceIntegrationService: PracticeIntegrationService,
  ) {}

  async fetch(
    learnerId: Learner['id'],
    where: ObjectQuery<CatalogDeck>,
    pagination: ParseQueryPagination,
  ): Promise<Result<CatalogDeck[]>> {
    try {
      const options = { ...pagination };
      const decks = await this.catalogDeckRepository.find(where, options);
      await this._assignProgress(decks, learnerId);
      return Result.success(decks);
    } catch {
      return Result.failure(`Failed to fetch decks.`);
    }
  }

  async fetchInProgress(
    learnerId: Learner['id'],
  ): Promise<Result<CatalogDeck[]>> {
    try {
      const progressList =
        await this.practiceIntegrationService.getProgressByLearner(learnerId);
      const inProgressDeckIds = progressList.map((it) => it.deckId);
      const decks = await this.catalogDeckRepository.find(inProgressDeckIds);
      this._assignExistingProgress(decks, progressList);
      return Result.success(decks);
    } catch {
      return Result.failure(`Failed to fetch decks.`);
    }
  }

  async fetchPopular(learnerId: Learner['id']): Promise<Result<CatalogDeck[]>> {
    try {
      const deckIds = await this.practiceIntegrationService.getPopularDeckIds();
      const decks = await this.catalogDeckRepository.find(deckIds);
      await this._assignProgress(decks, learnerId);
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
        populateOrderBy: { questions: { id: QueryOrder.ASC } },
      });
      if (!deck) return Result.failure('Deck not found');
      const previewDeck = this._mapCatalogDeckForPreview(deck, learnerId);
      return Result.success(previewDeck);
    } catch {
      return Result.failure(`Failed to fetch deck.`);
    }
  }

  async _assignProgress(
    decks: CatalogDeck[],
    learnerId: Learner['id'],
  ): Promise<void> {
    for (const deck of decks) {
      const payload = { learnerId, deckId: deck.id };
      const progress =
        await this.practiceIntegrationService.getProgress(payload);
      if (progress) deck.setProgress(progress.progress);
    }
  }

  _assignExistingProgress(
    decks: CatalogDeck[],
    progressList: CatalogPracticeProgress[],
  ): void {
    for (const deck of decks) {
      const progress = progressList.find((it) => it.deckId === deck.id);
      if (progress) deck.setProgress(progress.progress);
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
