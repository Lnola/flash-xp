import 'package:flashxp/features/create/logic/controllers/multiple_choice.controller.dart';
import 'package:flashxp/features/create/presentation/builders/question_form.builder.dart';
import 'package:flashxp/features/create/presentation/widgets/multiple_choice_legend.widget.dart';
import 'package:flashxp/features/create/presentation/widgets/multiple_choice_question_form.widget.dart';
import 'package:flutter/material.dart';

class MultipleChoiceQuestionFormBuilder implements QuestionFormBuilder {
  @override
  Widget buildInputs(
    List<dynamic> questionsControllers,
    void Function(dynamic) removeQuestion,
    void Function(dynamic, int) toggleIsCorrect,
  ) {
    final controllers = questionsControllers as List<MultipleChoiceController>;
    return MultipleChoiceQuestionFormWidget(
      questionsControllers: controllers,
      onRemoveInputGroup: removeQuestion,
      toggleIsAnswerOptionCorrect: toggleIsCorrect,
    );
  }

  @override
  Widget buildLegend() {
    return const MultipleChoiceLegendWidget();
  }
}
