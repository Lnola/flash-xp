import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_dropdown.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

extension on PracticeMode {
  String get label => switch (this) {
        PracticeMode.multipleChoice => 'Multiple Choice',
        PracticeMode.selfAssessment => 'Self Assessment',
      };

  Widget buildInputs(CreateController controller) => switch (this) {
        PracticeMode.multipleChoice =>
          FlashInputGroup<(TextEditingController, List<TextEditingController>)>(
            inputControllers: controller.multipleChoiceQuestions,
            onRemoveInputGroup: controller.removeMultipleChoiceQuestion,
            isDirty: (input) =>
                input.$1.text.isNotEmpty ||
                input.$2.any((c) => c.text.isNotEmpty),
            buildInputs: (input) => [
              FlashTextInput(label: 'Question', controller: input.$1),
              const SizedBox(height: 8),
              for (var i = 0; i < 4; i++) ...[
                FlashTextInput(
                  label: 'Option ${String.fromCharCode(65 + i)}',
                  controller: input.$2[i],
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        PracticeMode.selfAssessment =>
          FlashInputGroup<(TextEditingController, TextEditingController)>(
            inputControllers: controller.selfAssessmentPairs,
            onRemoveInputGroup: controller.removeSelfAssessmentPair,
            isDirty: (input) =>
                input.$1.text.isNotEmpty || input.$2.text.isNotEmpty,
            buildInputs: (input) => [
              FlashTextInput(label: 'Question', controller: input.$1),
              const SizedBox(height: 8),
              FlashTextInput(label: 'Answer', controller: input.$2),
            ],
          ),
      };

  void handleAddInput(CreateController controller) => switch (this) {
        PracticeMode.multipleChoice => controller.addMultipleChoiceQuestion(),
        PracticeMode.selfAssessment => controller.addDynamicInput(),
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
    controller = CreateController();
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
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.only(top: 8, bottom: 18),
      child: Column(
        children: [
          FlashTextInput(
            label: 'Full title',
            controller: controller.titleController,
          ),
          const SizedBox(height: 24),
          controller.mode.buildInputs(controller),
          FlashDropdown<PracticeMode>(
            value: controller.mode,
            values: PracticeMode.values,
            labelBuilder: (mode) => mode.label,
            onChanged: (mode) {
              if (mode != null) controller.updateMode(mode);
            },
          ),
          const SizedBox(height: 24),
          CreateActions(controller: controller),
        ],
      ),
    );
  }
}

class CreateActions extends StatelessWidget {
  final CreateController controller;

  const CreateActions({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            controller.mode.handleAddInput(controller);
          },
          child: const Text('Add input'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: controller.submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
