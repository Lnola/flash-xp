import 'package:flashxp/features/statistics/logic/models/daily_correct_incorrect.model.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/group_bar_chart_card.widget.dart';
import 'package:flashxp/shared/presentation/composables/snackbar.dart';
import 'package:flutter/material.dart';

class DailyCorrectIncorrectWidget extends StatelessWidget {
  final StatStore<List<DailyCorrectIncorrect>> dailyCorrectIncorrect;

  const DailyCorrectIncorrectWidget({
    super.key,
    required this.dailyCorrectIncorrect,
  });

  @override
  Widget build(BuildContext context) {
    if (dailyCorrectIncorrect.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        useSnackbar(context, dailyCorrectIncorrect.error, null);
      });
      return const SizedBox.shrink();
    }

    final days = dailyCorrectIncorrect.data?.map((it) => it.day).toList();
    final correct = dailyCorrectIncorrect.data
        ?.map((it) => double.tryParse(it.correct.toString()) ?? 0)
        .toList();
    final incorrect = dailyCorrectIncorrect.data
        ?.map((it) => double.tryParse(it.incorrect.toString()) ?? 0)
        .toList();

    return GroupBarChartCardWidget(
      isLoading: dailyCorrectIncorrect.isLoading,
      days: days ?? [],
      series: [
        BarSeries(
          label: 'Correct Answers',
          color: Theme.of(context).colorScheme.tertiary,
          values: correct ?? [],
        ),
        BarSeries(
          label: 'Incorrect Answers',
          color: Theme.of(context).colorScheme.error,
          values: incorrect ?? [],
        ),
      ],
    );
  }
}
