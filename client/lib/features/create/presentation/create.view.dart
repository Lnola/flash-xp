import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/presentation/widgets/flash_icon_button.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_checkbox.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_dropdown.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

extension on PracticeMode {
  String get label => switch (this) {
        PracticeMode.multipleChoice => 'Multiple Choice',
        PracticeMode.selfAssessment => 'Self Assessment',
      };

  // TODO: upgrade this
  Widget buildInputs(CreateController controller) => switch (this) {
        PracticeMode.multipleChoice =>
          FlashInputGroup<MultipleChoiceController>(
            inputControllers: controller.multipleChoiceControllers,
            onRemoveInputGroup: controller.removeQuestion,
            isDirty: (input) =>
                input.$1.text.isNotEmpty ||
                input.$2.any((c) => c.text.isNotEmpty),
            buildInputs: (input) => [
              FlashTextInput(label: 'Question', controller: input.$1),
              for (var i = 0; i < 4; i++) ...[
                Row(
                  children: [
                    Expanded(
                      child: FlashTextInput(
                        label: 'Option ${String.fromCharCode(65 + i)}',
                        controller: input.$2[i],
                      ),
                    ),
                    Tooltip(
                      message: 'Is this answer correct?',
                      child: FlashCheckbox(
                        value: input.$3[i],
                        onChanged: (_) => controller.toggleIsCorrect(input, i),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        PracticeMode.selfAssessment =>
          FlashInputGroup<SelfAssessmentController>(
            inputControllers: controller.selfAssessmentControllers,
            onRemoveInputGroup: controller.removeQuestion,
            isDirty: (input) =>
                input.$1.text.isNotEmpty || input.$2.text.isNotEmpty,
            buildInputs: (input) => [
              FlashTextInput(label: 'Question', controller: input.$1),
              const SizedBox(height: 8),
              FlashTextInput(label: 'Answer', controller: input.$2),
            ],
          ),
      };

  Widget buildLegend(CreateController controller) => switch (this) {
        PracticeMode.multipleChoice => Column(
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
          ),
        PracticeMode.selfAssessment => const SizedBox.shrink(),
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
          child: _CreateActions(
            addQuestion: controller.addQuestion,
            submit: controller.submit,
          ),
        ),
      ],
    );
  }
}

class _CreateActions extends StatelessWidget {
  final void Function() addQuestion;
  final void Function() submit;

  const _CreateActions({
    required this.addQuestion,
    required this.submit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlashIconButton(
          onPressed: addQuestion,
          label: 'Add Input',
          icon: FontAwesomeIcons.plus,
        ),
        const SizedBox(width: 12),
        FlashIconButton(
          onPressed: submit,
          label: 'Submit',
          icon: FontAwesomeIcons.check,
        ),
      ],
    );
  }
}
