import 'package:flashxp/features/create/logic/controllers/multiple_choice.controller.dart';
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
    return input.questionController.text.isNotEmpty ||
        input.answerOptionsControllers.any(
          (answerOptionController) =>
              answerOptionController.text.text.isNotEmpty,
        );
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
            input: input,
            i: i,
            toggleIsAnswerOptionCorrect: toggleIsAnswerOptionCorrect,
          ),
        ],
      ],
    );
  }
}

class _AnswerOptionForm extends StatelessWidget {
  final MultipleChoiceController input;
  final int i;
  final void Function(MultipleChoiceController p1, int p2)
      toggleIsAnswerOptionCorrect;

  const _AnswerOptionForm({
    required this.input,
    required this.i,
    required this.toggleIsAnswerOptionCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FlashTextInput(
            label: 'Option ${String.fromCharCode(65 + i)}',
            controller: input.answerOptionsControllers[i].text,
          ),
        ),
        Tooltip(
          message: 'Is this answer correct?',
          child: FlashCheckbox(
            value: input.answerOptionsControllers[i].isCorrect,
            onChanged: (_) => toggleIsAnswerOptionCorrect(input, i),
          ),
        ),
      ],
    );
  }
}
