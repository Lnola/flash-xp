class QuestionDto {
  final int id;
  final String text;

  QuestionDto({
    required this.id,
    required this.text,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) {
    return QuestionDto(
      id: json['id'],
      text: json['text'],
    );
  }
}

class DeckDto {
  final int id;
  final String title;
  final String description;
  final List<QuestionDto> questions;
  final bool isBookmarked;

  DeckDto({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.isBookmarked,
  });

  factory DeckDto.fromJson(Map<String, dynamic> json) {
    return DeckDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      questions: (json['questions'] as List)
          .map((q) => QuestionDto(id: q['id'], text: q['text']))
          .toList(),
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }
}
