import 'package:flashxp/features/create/data/dto/deck.dto.dart';

class CreateAnswerOptionDto extends AnswerOptionDto {
  CreateAnswerOptionDto({
    required super.text,
    required super.isCorrect,
  });
}

class CreateQuestionDto extends QuestionDto {
  CreateQuestionDto({
    required super.text,
    super.answer,
    required super.questionType,
    super.answerOptions,
  });
}

class CreateDeckDto extends DeckDto {
  CreateDeckDto({
    required super.title,
    required super.description,
    required super.questions,
  });
}
