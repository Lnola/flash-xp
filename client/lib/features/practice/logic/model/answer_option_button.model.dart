import 'package:flashxp/features/practice/presentation/widgets/practice_option_button.dart';
import 'package:flutter/material.dart';

class AnswerOptionButtonModel {
  final String label;
  final VoidCallback onPressed;
  final PracticeOptionState state;
  final bool isCorrect;
  final bool isDisabled;

  AnswerOptionButtonModel({
    required this.label,
    required this.onPressed,
    this.state = PracticeOptionState.defaultState,
    this.isCorrect = false,
    this.isDisabled = false,
  });

  AnswerOptionButtonModel copyWith({
    String? label,
    VoidCallback? onPressed,
    PracticeOptionState? state,
    bool? isCorrect,
    bool? isDisabled,
  }) {
    return AnswerOptionButtonModel(
      label: label ?? this.label,
      onPressed: onPressed ?? this.onPressed,
      state: state ?? this.state,
      isCorrect: isCorrect ?? this.isCorrect,
      isDisabled: isDisabled ?? this.isDisabled,
    );
  }
}
