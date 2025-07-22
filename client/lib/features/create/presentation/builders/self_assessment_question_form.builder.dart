import 'package:flashxp/features/create/logic/controllers/self_assessment.controller.dart';
import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/builders/question_form.builder.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

class SelfAssessmentQuestionFormBuilder implements QuestionFormBuilder {
  @override
  Widget buildInputs(CreateController controller) {
    return FlashInputGroup<SelfAssessmentController>(
      inputControllers:
          controller.questionsControllers as List<SelfAssessmentController>,
      onRemoveInputGroup: controller.removeQuestion,
      isDirty: (input) =>
          input.questionController.text.isNotEmpty ||
          input.answerController.text.isNotEmpty,
      buildInputs: (input) => [
        FlashTextInput(
          label: 'Question',
          controller: input.questionController,
        ),
        const SizedBox(height: 8),
        FlashTextInput(
          label: 'Answer',
          controller: input.answerController,
        ),
      ],
    );
  }

  @override
  Widget buildLegend(CreateController controller) {
    return const SizedBox.shrink();
  }
}
