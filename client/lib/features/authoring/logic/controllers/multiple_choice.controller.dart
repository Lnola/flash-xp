import 'package:flashxp/features/authoring/data/dto/deck.dto.dart';
import 'package:flutter/material.dart';

class AnswerOptionController {
  final TextEditingController text = TextEditingController();
  bool isCorrect = false;

  void toggleIsCorrect() {
    isCorrect = !isCorrect;
  }

  static AnswerOptionController fromDto(AnswerOptionDto answerOptionDto) {
    final controller = AnswerOptionController();
    controller.text.text = answerOptionDto.text;
    controller.isCorrect = answerOptionDto.isCorrect;
    return controller;
  }
}

class MultipleChoiceController {
  final TextEditingController questionController = TextEditingController();
  final List<AnswerOptionController> answerOptionsControllers =
      List.generate(4, (_) => AnswerOptionController());

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
      final optionController = AnswerOptionController.fromDto(answerOption);
      controller.answerOptionsControllers.add(optionController);
    }
    return controller;
  }
}
