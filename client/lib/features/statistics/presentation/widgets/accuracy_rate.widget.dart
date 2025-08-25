import 'package:flashxp/features/statistics/logic/models/accuracy_rate.model.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/percentage_card.widget.dart';
import 'package:flutter/material.dart';

class AccuracyRateWidget extends StatelessWidget {
  final StatStore<AccuracyRate> accuracyRate;

  const AccuracyRateWidget({
    super.key,
    required this.accuracyRate,
  });

  @override
  Widget build(BuildContext context) {
    if (accuracyRate.isLoading) {
      return const SizedBox.shrink();
    }

    return PercentageCardWidget(
      percent: accuracyRate.data!.value,
      label: 'Accuracy rate',
      radius: 56,
      lineWidth: 12,
    );
  }
}
