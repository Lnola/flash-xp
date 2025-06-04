import 'package:flashxp/pages/home/widgets/practice/practice_option_button.dart';
import 'package:flutter/material.dart';

class OptionButtonData {
  final String label;
  final VoidCallback onPressed;
  final PracticeOptionState state;

  OptionButtonData({
    required this.label,
    required this.onPressed,
    required this.state,
  });
}

class PracticeOptionList extends StatelessWidget {
  final List<OptionButtonData> options;

  const PracticeOptionList({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < options.length; i++) ...[
            if (i != 0) const SizedBox(width: 8),
            Expanded(
              child: PracticeOptionButton(
                label: options[i].label,
                onPressed: options[i].onPressed,
                state: options[i].state,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
