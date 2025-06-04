import 'package:flashxp/pages/home/widgets/practice/practice_option_button.dart';
import 'package:flutter/material.dart';

class PracticeOptionList extends StatelessWidget {
  const PracticeOptionList({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() {}

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PracticeOptionButton(
              label: "I don't know",
              onPressed: onPressed,
              state: PracticeOptionState.incorrect,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: PracticeOptionButton(
              label: 'I know',
              onPressed: onPressed,
              state: PracticeOptionState.correct,
            ),
          ),
        ],
      ),
    );
  }
}
