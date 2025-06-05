import 'package:flashxp/pages/home/widgets/practice/practice_option_button.dart';
import 'package:flutter/material.dart';

class OptionButtonData {
  final String label;
  final VoidCallback onPressed;
  final PracticeOptionState state;
  final bool isCorrect;
  final bool isDisabled;

  OptionButtonData({
    required this.label,
    required this.onPressed,
    this.state = PracticeOptionState.defaultState,
    this.isCorrect = false,
    this.isDisabled = false,
  });

  OptionButtonData copyWith({
    String? label,
    VoidCallback? onPressed,
    PracticeOptionState? state,
    bool? isCorrect,
    bool? isDisabled,
  }) {
    return OptionButtonData(
      label: label ?? this.label,
      onPressed: onPressed ?? this.onPressed,
      state: state ?? this.state,
      isCorrect: isCorrect ?? this.isCorrect,
      isDisabled: isDisabled ?? this.isDisabled,
    );
  }
}

class PracticeOptionList extends StatelessWidget {
  final List<OptionButtonData> options;

  const PracticeOptionList({super.key, required this.options});

  void noop() {}

  @override
  Widget build(BuildContext context) {
    final spacing = 8.0;

    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: options
              .map(
                (option) => SizedBox(
                  width: (constraints.maxWidth - spacing) / 2,
                  child: PracticeOptionButton(
                    label: option.label,
                    onPressed: !option.isDisabled ? option.onPressed : noop,
                    state: option.state,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
