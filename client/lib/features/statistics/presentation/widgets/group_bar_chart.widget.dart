import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GroupBarChartWidget extends StatelessWidget {
  final List<String> days;
  final List<double> first;
  final List<double> second;
  final double barWidth;
  final double groupSpace;

  const GroupBarChartWidget({
    super.key,
    required this.days,
    required this.first,
    required this.second,
    this.barWidth = 12,
    this.groupSpace = 4,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = [
      ...first,
      ...second,
    ].fold<double>(0, (p, e) => e > p ? e : p);

    return AspectRatio(
      aspectRatio: 1.8,
      child: BarChart(
        BarChartData(
          maxY: (maxY + 1).ceilToDouble(),
          barTouchData: const BarTouchData(enabled: true),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 5),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i < 0 || i >= days.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      days[i],
                      style: Theme.of(context).textTheme.labelSmall,
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
