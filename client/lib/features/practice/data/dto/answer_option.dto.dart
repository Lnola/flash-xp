class AnswerOptionDto {
  final String label;
  final bool isCorrect;

  AnswerOptionDto({
    required this.label,
    this.isCorrect = false,
  });
}
