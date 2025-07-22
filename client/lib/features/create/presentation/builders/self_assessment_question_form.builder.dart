import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/builders/question_form.builder.dart';
import 'package:flashxp/features/create/presentation/widgets/self_assessment_question_form.widget.dart';
import 'package:flutter/material.dart';

class SelfAssessmentQuestionFormBuilder implements QuestionFormBuilder {
  @override
  Widget buildInputs(CreateController controller) {
    return SelfAssessmentQuestionFormWidget(
      controller: controller,
    );
  }

  @override
  Widget buildLegend() {
    return const SizedBox.shrink();
  }
}
