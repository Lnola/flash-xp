class AnswerOptionDto {
  final String label;
  final bool isCorrect;

  AnswerOptionDto({
    required this.label,
    this.isCorrect = false,
  });

  factory AnswerOptionDto.fromJson(Map<String, dynamic> json) {
    return AnswerOptionDto(
      label: json['text'],
      isCorrect: json['isCorrect'] ?? false,
    );
  }
}
