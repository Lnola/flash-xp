import 'package:flashxp/features/create/data/dto/deck.dto.dart';

class UpdateAnswerOptionDto extends AnswerOptionDto {
  UpdateAnswerOptionDto({
    required super.text,
    required super.isCorrect,
  });
}

class UpdateQuestionDto extends QuestionDto {
  UpdateQuestionDto({
    required super.text,
    super.answer,
    required super.questionType,
    super.answerOptions,
  });
}

class UpdateDeckDto extends DeckDto {
  UpdateDeckDto({
    required super.title,
    required super.description,
    required super.questions,
  });
}
