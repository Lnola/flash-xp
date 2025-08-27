class QuestionTypeOccurrenceCount {
  final int multipleChoiceCount;
  final int selfAssessmentCount;

  QuestionTypeOccurrenceCount({
    required this.multipleChoiceCount,
    required this.selfAssessmentCount,
  });

  factory QuestionTypeOccurrenceCount.fromJson(Map<String, dynamic> json) {
    return QuestionTypeOccurrenceCount(
      multipleChoiceCount: json['multipleChoiceCount'],
      selfAssessmentCount: json['selfAssessmentCount'],
    );
  }
}
