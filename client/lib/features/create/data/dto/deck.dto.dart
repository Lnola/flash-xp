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

  factory AnswerOptionDto.fromJson(Map<String, dynamic> json) {
    return AnswerOptionDto(
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }
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

  factory QuestionDto.fromJson(Map<String, dynamic> json) {
    return QuestionDto(
      text: json['text'] as String,
      answer: json['answer'] as String?,
      questionType: json['questionType']['name'] as String,
      answerOptions: (json['answerOptions'] as List?)
          ?.map((o) => AnswerOptionDto.fromJson(o as Map<String, dynamic>))
          .toList(),
    );
  }
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

  factory DeckDto.fromJson(Map<String, dynamic> json) {
    return DeckDto(
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List)
          .map((q) => QuestionDto.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }
}
