class IncorrectlyAnsweredQuestions {
  final int id;
  final String text;
  final String deckTitle;
  final int count;

  IncorrectlyAnsweredQuestions({
    required this.id,
    required this.text,
    required this.deckTitle,
    required this.count,
  });

  factory IncorrectlyAnsweredQuestions.fromJson(Map<String, dynamic> json) {
    return IncorrectlyAnsweredQuestions(
      id: json['id'],
      text: json['text'],
      deckTitle: json['deckTitle'],
      count: json['count'],
    );
  }
}
