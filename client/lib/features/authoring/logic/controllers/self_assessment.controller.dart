import 'package:flashxp/features/authoring/data/dto/deck.dto.dart';
import 'package:flutter/material.dart';

class SelfAssessmentController {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  void dispose() {
    questionController.dispose();
    answerController.dispose();
  }

  static SelfAssessmentController fromDto(QuestionDto dto) {
    final controller = SelfAssessmentController();
    controller.questionController.text = dto.text;
    controller.answerController.text = dto.answer ?? '';
    return controller;
  }
}
