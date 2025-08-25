import 'package:flashxp/shared/presentation/widgets/flash_skeleton_box.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentageCardWidget extends StatelessWidget {
  final double percent;
  final String? label;
  final double radius;
  final double lineWidth;
  final Color? backgroundColor;
  final Color? progressColor;
  final bool isLoading;

  const PercentageCardWidget({
    super.key,
    required this.percent,
    this.label,
    this.radius = 60,
    this.lineWidth = 12,
    this.backgroundColor,
    this.progressColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return _SkeletonLoader();

    final theme = Theme.of(context);
    final bgColor =
        backgroundColor ?? theme.colorScheme.onSurface.withAlpha(33);
    final progColor = progressColor ?? theme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularPercentIndicator(
            radius: radius,
            lineWidth: lineWidth,
            percent: percent.clamp(0.0, 1.0),
            backgroundColor: bgColor,
            progressColor: progColor,
            circularStrokeCap: CircularStrokeCap.round,
            center: Text(
              '${(percent * 100).round()}%',
              style: theme.textTheme.titleLarge,
            ),
          ),
          if (label != null) ...[
            const SizedBox(height: 8),
            Text(
              label!,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}

class _SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withAlpha(99),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlashSkeletonBox(
            width: 120,
            height: 120,
            rounded: true,
          ),
          SizedBox(height: 12),
          FlashSkeletonBox(
            width: 60,
            height: 12,
            rounded: true,
          ),
        ],
      ),
    );
  }
}
