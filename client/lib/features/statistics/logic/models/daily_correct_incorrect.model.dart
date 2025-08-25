class DailyCorrectIncorrect {
  final String day;
  final int correct;
  final int incorrect;

  DailyCorrectIncorrect({
    required this.day,
    required this.correct,
    required this.incorrect,
  });

  static DailyCorrectIncorrect fromJson(Map<String, dynamic> json) {
    return DailyCorrectIncorrect(
      day: json['day'],
      correct: json['correct'],
      incorrect: json['incorrect'],
    );
  }
}
