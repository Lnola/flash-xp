import { ObjectQuery } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { Bookmark, CatalogDeck, Learner } from 'catalog/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { ParseQueryPagination } from 'shared/helpers/parse-query';
import { Result } from 'shared/helpers/result';

@Injectable()
export class CatalogDeckService {
  constructor(
    @InjectRepository(CatalogDeck)
    private readonly catalogDeckRepository: BaseEntityRepository<CatalogDeck>,
    @InjectRepository(Bookmark)
    private readonly bookmarkRepository: BaseEntityRepository<Bookmark>,
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
    } catch (error) {
      return Result.failure(`Failed to fetch decks: ${error}`);
    }
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
      deck,
      learnerId,
    });
    return {
      ...deck,
      questionType: deck.questionType,
      isCurrentUserAuthor: true,
      isBookmarked: !!deckBookmarkByCurrentUser,
    };
  }
}
