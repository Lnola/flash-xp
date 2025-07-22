import 'package:flutter/material.dart';

abstract class QuestionFormBuilder {
  Widget buildInputs(
    List<dynamic> questionsControllers,
    void Function(dynamic) removeQuestion,
    void Function(dynamic, int) toggleIsCorrect,
  );
  Widget buildLegend();
}
