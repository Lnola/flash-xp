import 'package:flutter/material.dart';

class SelfAssessmentController {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  void dispose() {
    questionController.dispose();
    answerController.dispose();
  }
}
