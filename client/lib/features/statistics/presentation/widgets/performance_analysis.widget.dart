import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PerformanceAnalysisWidget extends StatelessWidget {
  final StatStore<String> performanceAnalysis;

  const PerformanceAnalysisWidget({
    super.key,
    required this.performanceAnalysis,
  });

  @override
  Widget build(BuildContext context) {
    if (performanceAnalysis.isLoading ||
        performanceAnalysis.error != null ||
        performanceAnalysis.data == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          spacing: 8,
          children: [
            const FaIcon(FontAwesomeIcons.wandMagicSparkles, size: 16),
            Text(
              'AI performance analysis.',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        Text(
          performanceAnalysis.data!,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
