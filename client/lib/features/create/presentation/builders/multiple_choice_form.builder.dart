import 'package:flashxp/features/create/logic/controllers/multiple_choice.controller.dart';
import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/builders/create_form.builder.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_checkbox.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

class MultipleChoiceFormBuilder implements CreateFormBuilder {
  @override
  Widget buildInputs(CreateController controller) {
    return FlashInputGroup<MultipleChoiceController>(
      inputControllers:
          controller.questionsControllers as List<MultipleChoiceController>,
      onRemoveInputGroup: controller.removeQuestion,
      isDirty: (input) =>
          input.questionController.text.isNotEmpty ||
          input.answerOptionsControllers.any(
            (answerOptionController) =>
                answerOptionController.text.text.isNotEmpty,
          ),
      buildInputs: (input) => [
        FlashTextInput(
          label: 'Question',
          controller: input.questionController,
        ),
        for (var i = 0; i < 4; i++) ...[
          Row(
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
                  onChanged: (_) => controller.toggleIsCorrect(input, i),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  @override
  Widget buildLegend(CreateController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Legend:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlashCheckbox(
              value: false,
              onChanged: (_) => {},
              label: 'Wrong Option',
            ),
            FlashCheckbox(
              value: true,
              onChanged: (_) => {},
              label: 'Correct Option',
            ),
          ],
        ),
      ],
    );
  }
}
