import 'package:flashxp/features/authoring/data/dto/deck.dto.dart';
import 'package:flutter/material.dart';

// TODO: rename so its not plural
class AnswerOptionControllers {
  final TextEditingController text = TextEditingController();
  bool isCorrect = false;

  void toggleIsCorrect() {
    isCorrect = !isCorrect;
  }

  static AnswerOptionControllers fromDto(AnswerOptionDto answerOptionDto) {
    final controller = AnswerOptionControllers();
    controller.text.text = answerOptionDto.text;
    controller.isCorrect = answerOptionDto.isCorrect;
    return controller;
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

  static MultipleChoiceController fromDto(QuestionDto questionDto) {
    final controller = MultipleChoiceController();
    controller.questionController.text = questionDto.text;
    controller.answerOptionsControllers.clear();
    for (final answerOption in questionDto.answerOptions!) {
      final optionController = AnswerOptionControllers.fromDto(answerOption);
      controller.answerOptionsControllers.add(optionController);
    }
    return controller;
  }
}
