class AccuracyRate {
  final int correct;
  final int total;
  final double value;

  AccuracyRate({
    required this.correct,
    required this.total,
    required this.value,
  });

  factory AccuracyRate.fromJson(Map<String, dynamic> json) {
    return AccuracyRate(
      correct: json['correct'],
      total: json['total'],
      value: json['value']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correct': correct,
      'total': total,
      'value': value,
    };
  }
}
