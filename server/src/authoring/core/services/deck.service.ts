import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { CreateDeckDto, UpdateDeckDto } from 'authoring/api/dto';
import {
  Author,
  CreateDeckProps,
  Deck,
  UpdateDeckProps,
} from 'authoring/core/entities';
import { QuestionTypeProvider } from 'authoring/core/providers';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { Result } from 'shared/helpers/result';

@Injectable()
export class DeckService {
  constructor(
    @InjectRepository(Deck)
    private readonly deckRepository: BaseEntityRepository<Deck>,
    private readonly questionTypeProvider: QuestionTypeProvider,
  ) {}

  async populate(existingDeck: Deck): Promise<Result<Deck>> {
    const deck = await this.deckRepository.populate(existingDeck, [
      'questions',
      'questions.answerOptions',
    ]);
    if (!deck) return Result.failure('Deck not found');
    return Result.success(deck);
  }

  async create(
    authorId: Author['id'],
    dto: CreateDeckDto,
  ): Promise<Result<Deck>> {
    try {
      const payload: CreateDeckProps = this._mapDeckDtoToProps(dto, authorId);
      const newDeck = Deck.create(payload);
      await this.deckRepository.persistAndFlush(newDeck);
      return Result.success(newDeck);
    } catch (error) {
      return Result.failure(`Failed to create deck: ${error}`);
    }
  }

  async update(
    authorId: Author['id'],
    deckId: Deck['id'],
    dto: UpdateDeckDto,
  ): Promise<Result<Deck>> {
    try {
      const existingDeck = await this.deckRepository.findOne(deckId, {
        populate: ['questions', 'questions.answerOptions'],
      });
      if (!existingDeck) return Result.failure('Existing deck not found');
      const payload: UpdateDeckProps = this._mapDeckDtoToProps(dto, authorId);
      existingDeck.update(payload);
      await this.deckRepository.persistAndFlush(existingDeck);
      return Result.success(existingDeck);
    } catch (error) {
      return Result.failure(`Failed to update deck: ${error}`);
    }
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

  private _mapDeckDtoToProps(
    dto: CreateDeckDto | UpdateDeckDto,
    authorId: Author['id'],
  ): CreateDeckProps | UpdateDeckProps {
    return {
      ...dto,
      authorId,
      questionsProps: dto.questions?.map((question) => ({
        ...question,
        deck: null,
        questionType: this.questionTypeProvider.getByName(
          question.questionType,
        )!,
        answerOptionsProps: question.answerOptions?.map((option) => ({
          ...option,
          question: null,
        })),
      })),
    };
  }
}
