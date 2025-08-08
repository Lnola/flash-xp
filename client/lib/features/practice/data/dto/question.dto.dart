import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';

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

  PracticeMode get mode {
    final hasOptions = answerOptionDtos != null && answerOptionDtos!.isNotEmpty;
    return hasOptions
        ? PracticeMode.multipleChoice
        : PracticeMode.selfAssessment;
  }

  factory QuestionDto.fromJson(Map<String, dynamic> json) {
    return QuestionDto(
      id: json['id'],
      text: json['text'],
      answer: json['answer'],
      answerOptionDtos: (json['answerOptions'] as List?)
          ?.map((it) => AnswerOptionDto.fromJson(it))
          .toList(),
    );
  }
}
