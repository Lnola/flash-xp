import { AnswerOption } from 'authoring/core/entities';

export class AnswerOptionFactory {
  static create(data: CreateAnswerOptionProps): AnswerOption {
    return new AnswerOption(data);
  }
}

export type CreateAnswerOptionProps = Pick<
  AnswerOption,
  'text' | 'isCorrect' | 'question'
>;
