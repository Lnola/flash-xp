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

  // Instead of doing these fetch methods, create a more generic fetch method that accepts validated filters and options.
  // Currently this is backend for frontend, but it can be more flexible so the backend can be reused in other environments.
  async fetchInProgressByLearner(
    learnerId: Learner['id'],
  ): Promise<CatalogDeck[]> {
    // TODO: Implement logic to fetch in-progress decks
    return this.catalogDeckRepository.find({ authorId: learnerId });
  }

  async fetchAuthoredByLearner(
    learnerId: Learner['id'],
  ): Promise<CatalogDeck[]> {
    return this.catalogDeckRepository.find({ authorId: learnerId });
  }

  async fetchBookmarkedByLearner(
    learnerId: Learner['id'],
  ): Promise<CatalogDeck[]> {
    const decks = await this.catalogDeckRepository.find({
      bookmarks: { learnerId },
    });
    return decks;
  }

  async fetchMultipleChoiceDecks(): Promise<CatalogDeck[]> {
    return this.catalogDeckRepository.find(
      { questions: { questionType: { name: 'Multiple Choice' } } },
      { populate: ['questions.questionType'] },
    );
  }

  async fetchSelfAssessmentDecks(): Promise<CatalogDeck[]> {
    return this.catalogDeckRepository.find(
      { questions: { questionType: { name: 'Self Assessment' } } },
      { populate: ['questions.questionType'] },
    );
  }

  async fetchPopularDecks(): Promise<CatalogDeck[]> {
    // TODO: Implement logic to fetch popular decks
    return this.catalogDeckRepository.findAll();
  }
}
