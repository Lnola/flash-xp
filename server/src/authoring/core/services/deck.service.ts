import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { CreateDeckDto } from 'authoring/api/dto';
import { Author, Deck } from 'authoring/core/entities';
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

  async fetchById(deckId: Deck['id']): Promise<Result<Deck>> {
    const deck = await this.deckRepository.findOne(deckId, {
      populate: ['questions', 'questions.answerOptions'],
    });
    if (!deck) return Result.failure('Deck not found');
    return Result.success(deck);
  }

  // TODO: Do factories instead of app service holding the creation logic
  async create(
    authorId: Author['id'],
    dto: CreateDeckDto,
  ): Promise<Result<Deck>> {
    try {
      const newDeck = new Deck({
        authorId,
        title: dto.title,
        description: dto.description,
      });
      const questionsProps = dto.questions.map((question) => {
        const questionType = this.questionTypeProvider.getByName(
          question.questionType,
        )!;
        const answerOptionsProps = question.answerOptions?.map((option) => ({
          text: option.text,
          isCorrect: option.isCorrect,
        }));
        return {
          text: question.text,
          answer: question.answer,
          questionType,
          answerOptionsProps,
        };
      });
      newDeck.createQuestions(questionsProps);
      await this.deckRepository.persistAndFlush(newDeck);
      return Result.success(newDeck);
    } catch (error) {
      return Result.failure(`Failed to create deck: ${error}`);
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
}
