import { InjectRepository } from '@mikro-orm/nestjs';
import { ForeignKeyConstraintViolationException } from '@mikro-orm/postgresql';
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
    } catch {
      return Result.failure(`Failed to create deck.`);
    }
  }

  async update(
    authorId: Author['id'],
    existingDeck: Deck,
    dto: UpdateDeckDto,
  ): Promise<Result<Deck>> {
    try {
      const { error, data: populatedDeck } = await this.populate(existingDeck);
      if (error || !populatedDeck) return Result.failure(error!);
      const payload: UpdateDeckProps = this._mapDeckDtoToProps(dto, authorId);
      populatedDeck.update(payload);
      await this.deckRepository.persistAndFlush(populatedDeck);
      return Result.success(populatedDeck);
    } catch {
      return Result.failure(`Failed to update deck.`);
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
    const forkedDeck = originalDeck.fork(authorId);
    await this.deckRepository.persistAndFlush(forkedDeck);
    return Result.success(forkedDeck);
  }

  async remove(deck: Deck): Promise<Result<void>> {
    try {
      if (!deck) return Result.failure('Deck not found');
      await this.deckRepository.removeAndFlush(deck);
      return Result.success();
    } catch (error) {
      if (error instanceof ForeignKeyConstraintViolationException) {
        return Result.failure('You cannot delete a deck users are studying');
      }
      return Result.failure('Failed to remove deck');
    }
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
