import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GroupBarChartWidget extends StatelessWidget {
  final List<String> days;
  final List<double> first;
  final List<double> second;
  final String firstLabel;
  final String secondLabel;
  final double barWidth;
  final double groupSpace;

  const GroupBarChartWidget({
    super.key,
    required this.days,
    required this.first,
    required this.second,
    required this.firstLabel,
    required this.secondLabel,
    this.barWidth = 12,
    this.groupSpace = 4,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = [
      ...first,
      ...second,
    ].fold<double>(0, (p, e) => e > p ? e : p);

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
            firstLabel: firstLabel,
            secondLabel: secondLabel,
          ),
          const SizedBox(height: 20),
          _Chart(
            maxY: maxY,
            days: days,
            groupSpace: groupSpace,
            first: first,
            barWidth: barWidth,
            second: second,
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;

  const _Legend({
    required this.firstLabel,
    required this.secondLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          firstLabel,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(width: 24),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          secondLabel,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.maxY,
    required this.days,
    required this.groupSpace,
    required this.first,
    required this.barWidth,
    required this.second,
  });

  final double maxY;
  final List<String> days;
  final double groupSpace;
  final List<double> first;
  final double barWidth;
  final List<double> second;

  @override
  Widget build(BuildContext context) {
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
                BarChartRodData(
                  toY: first[i],
                  width: barWidth,
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                BarChartRodData(
                  toY: second[i],
                  width: barWidth,
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
