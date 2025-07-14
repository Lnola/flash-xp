class CreateAnswerOptionDto {
  text: string;
  isCorrect: boolean;
}

class CreateQuestionDto {
  text: string;
  answer?: string;
  questionType: string;
  answerOptions?: CreateAnswerOptionDto[];
}

export class CreateDeckDto {
  title: string;
  description: string;
  questions: CreateQuestionDto[];
}
