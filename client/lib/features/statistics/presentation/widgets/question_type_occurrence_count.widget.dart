import 'package:flashxp/features/statistics/logic/models/question_type_occurrence_count.model.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/pie_chart_card.widget.dart';
import 'package:flutter/material.dart';

class QuestionTypeOccurrenceCountWidget extends StatelessWidget {
  final StatStore<QuestionTypeOccurrenceCount> questionTypeOccurrenceCount;

  const QuestionTypeOccurrenceCountWidget({
    super.key,
    required this.questionTypeOccurrenceCount,
  });

  @override
  Widget build(BuildContext context) {
    return PieChartCardWidget(
      isLoading: questionTypeOccurrenceCount.isLoading,
      error: questionTypeOccurrenceCount.error,
      slices: [
        PieSlice(
          label: 'Self Assessment',
          value: questionTypeOccurrenceCount.data?.selfAssessmentCount ?? 0,
          color: Theme.of(context).colorScheme.secondary,
        ),
        PieSlice(
          label: 'Multiple Choice',
          value: questionTypeOccurrenceCount.data?.multipleChoiceCount ?? 0,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ],
    );
  }
}
