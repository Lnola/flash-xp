import 'package:flashxp/features/authoring/logic/controllers/multiple_choice.controller.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_checkbox.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

class MultipleChoiceQuestionFormWidget extends StatelessWidget {
  final List<MultipleChoiceController> questionsControllers;
  final void Function(MultipleChoiceController) onRemoveInputGroup;
  final void Function(MultipleChoiceController, int)
      toggleIsAnswerOptionCorrect;

  const MultipleChoiceQuestionFormWidget({
    super.key,
    required this.questionsControllers,
    required this.onRemoveInputGroup,
    required this.toggleIsAnswerOptionCorrect,
  });

  bool _isDirty(MultipleChoiceController input) {
    final isTextDirty = input.questionController.text.isNotEmpty;
    final isAnyAnswerOptionDirty = input.answerOptionsControllers.any(
      (answerOptionController) => answerOptionController.text.text.isNotEmpty,
    );
    return isTextDirty || isAnyAnswerOptionDirty;
  }

  @override
  Widget build(BuildContext context) {
    return FlashInputGroup<MultipleChoiceController>(
      inputControllers: questionsControllers,
      onRemoveInputGroup: onRemoveInputGroup,
      isDirty: _isDirty,
      buildInputs: (input) => [
        FlashTextInput(
          label: 'Question',
          controller: input.questionController,
        ),
        for (var i = 0; i < 4; i++) ...[
          _AnswerOptionForm(
            textLabel: 'Option ${String.fromCharCode(65 + i)}',
            textController: input.answerOptionsControllers[i].text,
            isCorrect: input.answerOptionsControllers[i].isCorrect,
            toggleIsCorrect: (_) => toggleIsAnswerOptionCorrect(input, i),
          ),
        ],
      ],
    );
  }
}

class _AnswerOptionForm extends StatelessWidget {
  final String textLabel;
  final TextEditingController textController;
  final bool isCorrect;
  final void Function(dynamic) toggleIsCorrect;

  const _AnswerOptionForm({
    required this.textLabel,
    required this.textController,
    required this.isCorrect,
    required this.toggleIsCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FlashTextInput(
            label: textLabel,
            controller: textController,
          ),
        ),
        Tooltip(
          message: 'Is this answer correct?',
          child: FlashCheckbox(
            value: isCorrect,
            onChanged: toggleIsCorrect,
          ),
        ),
      ],
    );
  }
}
