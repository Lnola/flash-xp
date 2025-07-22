import 'package:flashxp/features/create/logic/controllers/self_assessment.controller.dart';
import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/builders/question_form.builder.dart';
import 'package:flashxp/features/create/presentation/widgets/self_assessment_question_form.widget.dart';
import 'package:flutter/material.dart';

class SelfAssessmentQuestionFormBuilder implements QuestionFormBuilder {
  @override
  Widget buildInputs(CreateController controller) {
    final questionsControllers =
        controller.questionsControllers as List<SelfAssessmentController>;
    return SelfAssessmentQuestionFormWidget(
      questionsControllers: questionsControllers,
      onRemoveInputGroup: controller.removeQuestion,
    );
  }

  @override
  Widget buildLegend() {
    return const SizedBox.shrink();
  }
}
