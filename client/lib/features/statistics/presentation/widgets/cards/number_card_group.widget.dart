import 'package:flashxp/features/statistics/presentation/widgets/cards/number_card.widget.dart';
import 'package:flutter/material.dart';

class NumberCardGroupWidget extends StatelessWidget {
  final List<String> values;
  final List<String> labels;

  const NumberCardGroupWidget({
    super.key,
    required this.values,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        for (int i = 0; i < values.length; i++)
          Expanded(
            child: NumberCardWidget(
              value: values[i],
              label: labels[i],
            ),
          ),
      ],
    );
  }
}
