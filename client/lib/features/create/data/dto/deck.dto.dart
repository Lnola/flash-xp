class AnswerOptionDto {
  final String text;
  final bool isCorrect;

  AnswerOptionDto({
    required this.text,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'isCorrect': isCorrect,
      };
}

class QuestionDto {
  final String text;
  final String? answer;
  final String questionType;
  final List<AnswerOptionDto>? answerOptions;

  QuestionDto({
    required this.text,
    this.answer,
    required this.questionType,
    this.answerOptions,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'answer': answer,
        'questionType': questionType,
        'answerOptions': answerOptions?.map((o) => o.toJson()).toList(),
      };
}

class DeckDto {
  final String title;
  final String description;
  final List<QuestionDto> questions;

  DeckDto({
    required this.title,
    required this.description,
    required this.questions,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'questions': questions.map((q) => q.toJson()).toList(),
      };
}
