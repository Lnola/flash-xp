import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/logic/controllers/multiple_choice.controller.dart';
import 'package:flashxp/features/create/logic/controllers/self_assessment.controller.dart';
import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/widgets/create_form_actions.widget.dart';
import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_checkbox.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_dropdown.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

abstract class CreateFormBuilder {
  Widget buildInputs(CreateController controller);
  Widget buildLegend(CreateController controller);
}

class MultipleChoiceFormBuilder implements CreateFormBuilder {
  @override
  Widget buildInputs(CreateController controller) {
    return FlashInputGroup<MultipleChoiceController>(
      inputControllers: controller.multipleChoiceControllers,
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

class SelfAssessmentFormBuilder implements CreateFormBuilder {
  @override
  Widget buildInputs(CreateController controller) {
    return FlashInputGroup<SelfAssessmentController>(
      inputControllers: controller.selfAssessmentControllers,
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

extension on PracticeMode {
  Widget buildInputs(CreateController controller) => switch (this) {
        PracticeMode.multipleChoice =>
          MultipleChoiceFormBuilder().buildInputs(controller),
        PracticeMode.selfAssessment =>
          SelfAssessmentFormBuilder().buildInputs(controller),
      };

  Widget buildLegend(CreateController controller) => switch (this) {
        PracticeMode.multipleChoice =>
          MultipleChoiceFormBuilder().buildLegend(controller),
        PracticeMode.selfAssessment =>
          SelfAssessmentFormBuilder().buildLegend(controller),
      };
}

class CreateView extends StatefulWidget {
  const CreateView({super.key});

  @override
  State<CreateView> createState() => CreateViewState();
}

class CreateViewState extends State<CreateView> {
  late final CreateController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = CreateController(CreateRepository());
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    controller.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) async {
    final result = await controller.submit();
    if (!context.mounted) return;
    useSnackbar(context, result.error, 'Deck successfully created!');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.only(top: 8, bottom: 120),
          child: Column(
            spacing: 8,
            children: [
              FlashTextInput(
                label: 'Full title',
                controller: controller.titleController,
              ),
              FlashTextInput(
                label: 'Description',
                controller: controller.descriptionController,
              ),
              const SizedBox(height: 16),
              controller.mode.buildLegend(controller),
              controller.mode.buildInputs(controller),
              FlashDropdown<PracticeMode>(
                value: controller.mode,
                values: PracticeMode.values,
                labelBuilder: (mode) => mode.label,
                onChanged: (mode) => controller.updateMode(mode!),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CreateFormActionsWidget(
            addQuestion: controller.addQuestion,
            submit: _submit,
          ),
        ),
      ],
    );
  }
}
