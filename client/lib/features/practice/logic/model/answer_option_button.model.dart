import 'package:flutter/material.dart';

// TODO: rename folder to models instead of model
enum AnswerOptionButtonState {
  defaultState,
  correct,
  incorrect,
}

class AnswerOptionButtonModel {
  final String label;
  final VoidCallback onPressed;
  final AnswerOptionButtonState state;
  final bool isCorrect;
  final bool isDisabled;

  AnswerOptionButtonModel({
    required this.label,
    required this.onPressed,
    this.state = AnswerOptionButtonState.defaultState,
    this.isCorrect = false,
    this.isDisabled = false,
  });

  AnswerOptionButtonModel copyWith({
    String? label,
    VoidCallback? onPressed,
    AnswerOptionButtonState? state,
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
