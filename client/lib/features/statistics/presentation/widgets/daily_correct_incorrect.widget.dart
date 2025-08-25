import 'dart:math';

import 'package:flashxp/features/statistics/logic/models/daily_correct_incorrect.model.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/group_bar_chart_card.widget.dart';
import 'package:flashxp/shared/presentation/widgets/flash_skeleton_box.dart';
import 'package:flutter/material.dart';

class DailyCorrectIncorrectWidget extends StatelessWidget {
  final StatStore<List<DailyCorrectIncorrect>> dailyCorrectIncorrect;

  const DailyCorrectIncorrectWidget({
    super.key,
    required this.dailyCorrectIncorrect,
  });

  @override
  Widget build(BuildContext context) {
    if (dailyCorrectIncorrect.isLoading) {
      return _SkeletonLoader();
    }

    final days = dailyCorrectIncorrect.data?.map((it) => it.day).toList();
    final correct = dailyCorrectIncorrect.data
        ?.map((it) => double.tryParse(it.correct.toString()) ?? 0)
        .toList();
    final incorrect = dailyCorrectIncorrect.data
        ?.map((it) => double.tryParse(it.incorrect.toString()) ?? 0)
        .toList();

    return GroupBarChartCardWidget(
      days: days!,
      series: [
        BarSeries(
          label: 'Correct Answers',
          color: Theme.of(context).colorScheme.tertiary,
          values: correct!,
        ),
        BarSeries(
          label: 'Incorrect Answers',
          color: Theme.of(context).colorScheme.error,
          values: incorrect!,
        ),
      ],
    );
  }
}

class _SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withAlpha(99),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      height: 276,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(14, (i) {
                return FlashSkeletonBox(
                  width: 12,
                  height: Random().nextInt(60) + 40,
                  rounded: true,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
