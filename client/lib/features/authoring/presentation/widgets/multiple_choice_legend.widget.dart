import 'package:flashxp/shared/presentation/widgets/input/flash_checkbox.dart';
import 'package:flutter/material.dart';

class MultipleChoiceLegendWidget extends StatelessWidget {
  const MultipleChoiceLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Legend:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlashCheckbox(
              value: false,
              onChanged: (_) => {},
              label: 'Wrong Option',
            ),
            FlashCheckbox(
              value: true,
              onChanged: (_) => {},
              label: 'Correct Option',
            ),
          ],
        ),
      ],
    );
  }
}
