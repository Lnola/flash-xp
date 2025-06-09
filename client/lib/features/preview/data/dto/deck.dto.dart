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

  DeckDto({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });
}
