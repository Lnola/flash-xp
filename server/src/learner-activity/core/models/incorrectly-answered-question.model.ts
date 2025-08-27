export class IncorrectlyAnsweredQuestionModel {
  questionId: number;
  count: number;

  constructor({
    questionId,
    count,
  }: IncorrectlyAnsweredQuestionModelConstructorProps) {
    this.questionId = questionId;
    this.count = count;
  }
}

type IncorrectlyAnsweredQuestionModelConstructorProps = {
  questionId: number;
  count: number;
};
