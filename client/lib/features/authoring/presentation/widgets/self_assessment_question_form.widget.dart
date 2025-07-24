import 'package:flashxp/features/authoring/logic/controllers/self_assessment.controller.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

class SelfAssessmentQuestionFormWidget extends StatelessWidget {
  final List<SelfAssessmentController> questionsControllers;
  final void Function(SelfAssessmentController) onRemoveInputGroup;

  const SelfAssessmentQuestionFormWidget({
    super.key,
    required this.questionsControllers,
    required this.onRemoveInputGroup,
  });

  bool _isDirty(SelfAssessmentController input) {
    final isTextDirty = input.questionController.text.isNotEmpty;
    final isAnyAnswerOptionDirty = input.answerController.text.isNotEmpty;
    return isTextDirty || isAnyAnswerOptionDirty;
  }

  @override
  Widget build(BuildContext context) {
    return FlashInputGroup<SelfAssessmentController>(
      inputControllers: questionsControllers,
      onRemoveInputGroup: onRemoveInputGroup,
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
