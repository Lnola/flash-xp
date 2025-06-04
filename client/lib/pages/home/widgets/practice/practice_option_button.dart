import 'package:flutter/material.dart';

enum PracticeOptionState {
  defaultState,
  correct,
  incorrect,
}

class PracticeOptionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final PracticeOptionState state;

  const PracticeOptionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.state = PracticeOptionState.defaultState,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;

    switch (state) {
      case PracticeOptionState.correct:
        backgroundColor = Theme.of(context).colorScheme.tertiary;
        foregroundColor = Theme.of(context).colorScheme.onTertiary;
        break;
      case PracticeOptionState.incorrect:
        backgroundColor = Theme.of(context).colorScheme.error;
        foregroundColor = Theme.of(context).colorScheme.onError;
        break;
      case PracticeOptionState.defaultState:
        backgroundColor = Theme.of(context).colorScheme.inverseSurface;
        foregroundColor = Theme.of(context).colorScheme.onInverseSurface;
    }

    return SizedBox(
      width: 192,
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
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
