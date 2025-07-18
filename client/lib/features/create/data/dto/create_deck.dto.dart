class CreateAnswerOptionDto {
  final String text;
  final bool isCorrect;

  CreateAnswerOptionDto({
    required this.text,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'isCorrect': isCorrect,
      };
}

class CreateQuestionDto {
  final String text;
  final String? answer;
  final String questionType;
  final List<CreateAnswerOptionDto>? answerOptions;

  CreateQuestionDto({
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

class CreateDeckDto {
  final String title;
  final String description;
  final List<CreateQuestionDto> questions;

  CreateDeckDto({
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
