import 'package:fl_chart/fl_chart.dart';
import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flashxp/shared/presentation/widgets/flash_skeleton_box.dart';
import 'package:flutter/material.dart';

class PieSlice {
  final String label;
  final int value;
  final Color color;

  PieSlice({
    required this.label,
    required this.value,
    required this.color,
  });
}

class PieChartCardWidget extends StatelessWidget {
  final List<PieSlice> slices;
  final bool isLoading;
  final String? error;

  const PieChartCardWidget({
    super.key,
    required this.slices,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return _SkeletonLoader();
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        useSnackbar(context, error, null);
      });
    }
    if (slices[0].value == 0 && slices[1].value == 0) {
      return const SizedBox.shrink();
    }

    final total = slices.fold<double>(0, (sum, item) => sum + item.value);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _Chart(slices: slices, total: total),
          const SizedBox(height: 12),
          _Legend(slices: slices),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final List<PieSlice> slices;

  const _Legend({
    required this.slices,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: slices.map((slice) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: slice.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              slice.label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _Chart extends StatelessWidget {
  final List<PieSlice> slices;
  final double total;

  const _Chart({
    required this.slices,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: PieChart(
        PieChartData(
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: slices.map((slice) {
            final percentage = total == 0 ? 0 : (slice.value / total * 100);
            return PieChartSectionData(
              color: slice.color,
              value: slice.value.toDouble(),
              showTitle: true,
              title: '${percentage.toStringAsFixed(1)}%',
              titleStyle: Theme.of(context).textTheme.bodySmall,
              radius: 56,
              titlePositionPercentageOffset: 0.5,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 264,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withAlpha(99),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(),
          FlashSkeletonBox(
            width: 200,
            height: 200,
            rounded: true,
          ),
        ],
      ),
    );
  }
}
