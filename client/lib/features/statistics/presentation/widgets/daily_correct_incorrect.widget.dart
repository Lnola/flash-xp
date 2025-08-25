import 'package:flashxp/features/statistics/logic/models/daily_correct_incorrect.model.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/group_bar_chart_card.widget.dart';
import 'package:flutter/material.dart';

class DailyCorrectIncorrectWidget extends StatelessWidget {
  final StatStore<DailyCorrectIncorrect> dailyCorrectIncorrect;

  const DailyCorrectIncorrectWidget({
    super.key,
    required this.dailyCorrectIncorrect,
  });

  @override
  Widget build(BuildContext context) {
    return GroupBarChartCardWidget(
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      series: [
        BarSeries(
          label: 'Correct Answers',
          color: Theme.of(context).colorScheme.tertiary,
          values: [3, 2, 5, 4, 3, 1, 2],
        ),
        BarSeries(
          label: 'Incorrect Answers',
          color: Theme.of(context).colorScheme.error,
          values: [1, 3, 2, 5, 2, 2, 10],
        ),
      ],
    );
  }
}
