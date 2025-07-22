import 'package:flashxp/features/create/logic/controllers/self_assessment.controller.dart';
import 'package:flashxp/features/create/presentation/builders/question_form.builder.dart';
import 'package:flashxp/features/create/presentation/widgets/self_assessment_question_form.widget.dart';
import 'package:flutter/material.dart';

class SelfAssessmentQuestionFormBuilder implements QuestionFormBuilder {
  @override
  Widget buildInputs(
    List<dynamic> questionsControllers,
    void Function(dynamic) removeQuestion,
    void Function(dynamic, int) _,
  ) {
    final controllers = questionsControllers as List<SelfAssessmentController>;
    return SelfAssessmentQuestionFormWidget(
      questionsControllers: controllers,
      onRemoveInputGroup: removeQuestion,
    );
  }

  @override
  Widget buildLegend() {
    return const SizedBox.shrink();
  }
}
