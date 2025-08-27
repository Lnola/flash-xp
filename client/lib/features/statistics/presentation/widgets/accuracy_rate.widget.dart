import 'package:flashxp/features/statistics/logic/models/accuracy_rate.model.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/percentage_card.widget.dart';
import 'package:flutter/material.dart';

class AccuracyRateWidget extends StatelessWidget {
  final StatStore<AccuracyRate> accuracyRate;
  final String label;

  const AccuracyRateWidget({
    super.key,
    required this.accuracyRate,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return PercentageCardWidget(
      isLoading: accuracyRate.isLoading,
      error: accuracyRate.error,
      percent: accuracyRate.data?.value,
      label: label,
      radius: 50,
      lineWidth: 12,
    );
  }
}
