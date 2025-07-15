import { AnswerOption, Question } from 'authoring/core/entities';
import { AnswerOptionFactory, CreateAnswerOptionProps } from '.';

export class QuestionFactory {
  static create(data: CreateQuestionProps): Question {
    const newQuestion = new Question(data);
    if (data.answerOptionsProps) {
      const newAnswerOptions = this._createAnswerOptions(
        newQuestion,
        data.answerOptionsProps,
      );
      newQuestion.setAnswerOptions(newAnswerOptions);
    }
    return newQuestion;
  }

  private static _createAnswerOptions(
    newQuestion: Question,
    answerOptionsProps: Omit<CreateAnswerOptionProps, 'question'>[],
  ): AnswerOption[] {
    return answerOptionsProps.map((answerOption) =>
      AnswerOptionFactory.create({
        ...answerOption,
        question: newQuestion,
      }),
    );
  }
}

export type CreateQuestionProps = {
  text: Question['text'];
  answer?: Question['answer'];
  questionType: Question['questionType'];
  deck: Question['deck'];
  answerOptionsProps?: Omit<CreateAnswerOptionProps, 'question'>[];
};
