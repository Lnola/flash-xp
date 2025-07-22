import 'package:flutter/material.dart';

class AnswerOptionControllers {
  final TextEditingController text = TextEditingController();
  bool isCorrect = false;

  void toggleIsCorrect() {
    isCorrect = !isCorrect;
  }
}

class MultipleChoiceController {
  final TextEditingController questionController = TextEditingController();
  final List<AnswerOptionControllers> answerOptionsControllers =
      List.generate(4, (_) => AnswerOptionControllers());

  void dispose() {
    questionController.dispose();
    for (final answerOption in answerOptionsControllers) {
      answerOption.text.dispose();
    }
  }
}
