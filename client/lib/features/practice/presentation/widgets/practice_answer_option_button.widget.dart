import 'package:flashxp/features/practice/logic/model/answer_option_button.model.dart';
import 'package:flutter/material.dart';

class PracticeAnswerOptionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final AnswerOptionButtonState state;

  const PracticeAnswerOptionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.state = AnswerOptionButtonState.defaultState,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;

    switch (state) {
      case AnswerOptionButtonState.correct:
        backgroundColor = Theme.of(context).colorScheme.tertiary;
        foregroundColor = Theme.of(context).colorScheme.onTertiary;
        break;
      case AnswerOptionButtonState.incorrect:
        backgroundColor = Theme.of(context).colorScheme.error;
        foregroundColor = Theme.of(context).colorScheme.onError;
        break;
      case AnswerOptionButtonState.defaultState:
        backgroundColor = Theme.of(context).colorScheme.inverseSurface;
        foregroundColor = Theme.of(context).colorScheme.onInverseSurface;
    }

    return SizedBox(
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: Theme.of(context).textTheme.labelMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
