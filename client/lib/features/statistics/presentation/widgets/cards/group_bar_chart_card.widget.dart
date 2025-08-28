import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flashxp/shared/presentation/widgets/flash_skeleton_box.dart';
import 'package:flutter/material.dart';

class BarSeries {
  final String label;
  final Color color;
  final List<double> values;

  const BarSeries({
    required this.label,
    required this.color,
    required this.values,
  });
}

class GroupBarChartCardWidget extends StatelessWidget {
  final List<String> days;
  final List<BarSeries> series;
  final double barWidth;
  final double groupSpace;
  final bool isLoading;

  const GroupBarChartCardWidget({
    super.key,
    required this.days,
    required this.series,
    this.barWidth = 12,
    this.groupSpace = 4,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return _SkeletonLoader();

    final maxY =
        series.expand((s) => s.values).fold<double>(0, (p, e) => e > p ? e : p);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
        left: 16.0,
        right: 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Legend(
            series: series,
          ),
          const SizedBox(height: 20),
          _Chart(
            maxY: maxY,
            days: days,
            groupSpace: groupSpace,
            series: series,
            barWidth: barWidth,
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final List<BarSeries> series;

  const _Legend({
    required this.series,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 0; i < series.length; i++) ...[
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: series[i].color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            series[i].label,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          if (i != series.length - 1) const SizedBox(width: 24),
        ],
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.maxY,
    required this.days,
    required this.groupSpace,
    required this.series,
    required this.barWidth,
  });

  final double maxY;
  final List<String> days;
  final double groupSpace;
  final List<BarSeries> series;
  final double barWidth;

  @override
  Widget build(BuildContext context) {
    final isThereCorrectAnswers =
        series[0].values.every((value) => value == 0.0);
    final isThereIncorrectAnswers =
        (series[1].values.every((value) => value == 0.0));
    if (isThereCorrectAnswers && isThereIncorrectAnswers) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 82.0, horizontal: 8.0),
        child: Text(
          'No data available.\nStart practicing to generate statistics.',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.8,
      child: BarChart(
        BarChartData(
          maxY: (maxY + 1).ceilToDouble(),
          barTouchData: const BarTouchData(enabled: true),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(77),
                        ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i < 0 || i >= days.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      days[i],
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(77),
                          ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(days.length, (i) {
            return BarChartGroupData(
              x: i,
              barsSpace: groupSpace,
              barRods: [
                for (final s in series)
                  BarChartRodData(
                    toY: s.values[i],
                    width: barWidth,
                    borderRadius: BorderRadius.circular(4),
                    color: s.color,
                  ),
              ],
            );
          }),
        ),
      ),
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
