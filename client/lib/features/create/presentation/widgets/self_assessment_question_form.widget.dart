import 'package:flashxp/features/create/logic/controllers/self_assessment.controller.dart';
import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

class SelfAssessmentQuestionFormWidget extends StatelessWidget {
  final CreateController controller;

  const SelfAssessmentQuestionFormWidget({
    super.key,
    required this.controller,
  });

  bool _isDirty(SelfAssessmentController input) {
    final isTextDirty = input.questionController.text.isNotEmpty;
    final isAnyAnswerOptionDirty = input.answerController.text.isNotEmpty;
    return isTextDirty || isAnyAnswerOptionDirty;
  }

  @override
  Widget build(BuildContext context) {
    return FlashInputGroup<SelfAssessmentController>(
      inputControllers:
          controller.questionsControllers as List<SelfAssessmentController>,
      onRemoveInputGroup: controller.removeQuestion,
      isDirty: _isDirty,
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
}
