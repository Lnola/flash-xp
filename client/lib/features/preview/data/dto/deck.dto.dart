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
  final bool isCurrentUserAuthor;

  DeckDto({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.isBookmarked,
    required this.isCurrentUserAuthor,
  });

  factory DeckDto.fromJson(Map<String, dynamic> json) {
    return DeckDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      questions: (json['questions'] as List)
          .map((q) => QuestionDto.fromJson(q as Map<String, dynamic>))
          .toList(),
      isBookmarked: json['isBookmarked'] ?? false,
      isCurrentUserAuthor: json['isCurrentUserAuthor'] ?? false,
    );
  }
}
