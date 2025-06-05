import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';

class QuestionDto {
  final int id;
  final String text;
  final String? answer;
  final List<AnswerOptionDto>? answerOptionDtos;

  QuestionDto({
    required this.id,
    required this.text,
    this.answer,
    this.answerOptionDtos,
  });
}
