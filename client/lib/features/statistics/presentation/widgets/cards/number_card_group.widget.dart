import 'package:flashxp/features/statistics/presentation/widgets/cards/number_card.widget.dart';
import 'package:flutter/material.dart';

class NumberCardGroup {
  final String value;
  final String label;
  final bool isLoading;

  NumberCardGroup({
    required this.value,
    required this.label,
    this.isLoading = false,
  });
}

class NumberCardGroupWidget extends StatelessWidget {
  final List<NumberCardGroup> groups;

  const NumberCardGroupWidget({
    super.key,
    required this.groups,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        for (final group in groups)
          Expanded(
            child: NumberCardWidget(
              value: group.value,
              label: group.label,
              isLoading: group.isLoading,
            ),
          ),
      ],
    );
  }
}
