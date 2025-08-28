import 'package:flashxp/features/statistics/logic/models/accuracy_rate.model.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flutter/material.dart';

class AccuracyRateTipsWidget extends StatelessWidget {
  final StatStore<AccuracyRate> multipleChoiceAccuracyRate;
  final StatStore<AccuracyRate> selfAssessmentAccuracyRate;

  const AccuracyRateTipsWidget({
    super.key,
    required this.multipleChoiceAccuracyRate,
    required this.selfAssessmentAccuracyRate,
  });

  String? buildAccuracyInsight() {
    if (multipleChoiceAccuracyRate.data == null ||
        selfAssessmentAccuracyRate.data == null) {
      return null;
    }
    final multipleChoiceValue = multipleChoiceAccuracyRate.data!.value;
    final selfAssessmentValue = selfAssessmentAccuracyRate.data!.value;
    final gap = (multipleChoiceValue - selfAssessmentValue).abs();

    if (multipleChoiceValue > 0.75 && selfAssessmentValue < 0.5) {
      return 'You recognize answers well in multiple choice, but recalling without options is tougher. Try more self-assessment practice to boost recall.';
    }
    if (selfAssessmentValue > 0.75 && multipleChoiceValue < 0.5) {
      return 'You can recall answers freely, but slip on multiple choice. Focus on reading questions carefully and avoiding distractors.';
    }
    if (multipleChoiceValue == 0 && selfAssessmentValue == 0) {
      return 'There are no values to analyze. Start practicing!';
    }
    if (multipleChoiceValue < 0.5 && selfAssessmentValue < 0.5) {
      return 'Both recognition and recall are challenging right now. Revisit the basics for a stronger foundations.';
    }
    if (multipleChoiceValue > 0.8 && selfAssessmentValue > 0.8) {
      return 'Great job! You perform well on both recognition and recall. Consider tackling harder decks or increasing intervals.';
    }
    if (gap > 0.2) {
      return multipleChoiceValue > selfAssessmentValue
          ? 'Your recognition (multiple choice) is stronger than recall. Balance it with more self-assessment.'
          : 'Your recall (self-assessment) is stronger than recognition. Balance it with more multiple choice practice.';
    }
    return 'Your accuracy is balanced across both question types. Keep practicing consistently.';
  }

  @override
  Widget build(BuildContext context) {
    final insights = buildAccuracyInsight();
    if (insights == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Question type insights.',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          insights,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
