import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flashxp/shared/presentation/widgets/flash_skeleton_box.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentageCardWidget extends StatelessWidget {
  final double? percent;
  final String? label;
  final double radius;
  final double lineWidth;
  final Color? backgroundColor;
  final Color? progressColor;
  final bool isLoading;
  final String? error;

  const PercentageCardWidget({
    super.key,
    this.percent,
    this.label,
    this.radius = 60,
    this.lineWidth = 12,
    this.backgroundColor,
    this.progressColor,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return _SkeletonLoader();
    if (error != null || percent == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        useSnackbar(context, error, null);
      });
    }

    final theme = Theme.of(context);
    final bgColor =
        backgroundColor ?? theme.colorScheme.onSurface.withAlpha(33);
    final progColor = progressColor ?? theme.colorScheme.onSurface;

    final localPercent = percent ?? 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 184,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularPercentIndicator(
            radius: radius,
            lineWidth: lineWidth,
            percent: localPercent.clamp(0.0, 1.0),
            backgroundColor: bgColor,
            progressColor: progColor,
            circularStrokeCap: CircularStrokeCap.round,
            center: Text(
              '${(localPercent * 100).round()}%',
              style: theme.textTheme.titleLarge,
            ),
          ),
          if (label != null) ...[
            const SizedBox(height: 8),
            Text(
              label!,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
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
      height: 184,
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
