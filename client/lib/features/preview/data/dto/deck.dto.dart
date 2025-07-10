class Question {
  final int id;
  final String text;

  Question({
    required this.id,
    required this.text,
  });
}

class DeckDto {
  final int id;
  final String title;
  final String description;
  final List<Question> questions;
  final bool isBookmarked;

  DeckDto({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.isBookmarked,
  });

  static DeckDto fromJson(json) {
    return DeckDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      questions: (json['questions'] as List)
          .map((q) => Question(id: q['id'], text: q['text']))
          .toList(),
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }
}
