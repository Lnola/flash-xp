import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/widgets/create_input.widget.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_mode_input_group.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmDeleteDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Remove question'),
      content: const Text('Are you sure you want to remove this question?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Remove'),
        ),
      ],
    ),
  );
  return result ?? false;
}

extension on PracticeMode {
  String get label => switch (this) {
        PracticeMode.multipleChoice => 'Multiple Choice',
        PracticeMode.selfAssessment => 'Self Assessment',
      };

  Widget buildInputs(CreateController controller) => switch (this) {
        PracticeMode.multipleChoice => MultipleChoiceInputs(
            inputControllers: controller.multipleChoiceQuestions,
            onRemoveInputGroup: controller.removeMultipleChoiceQuestion,
          ),
        PracticeMode.selfAssessment => SelfAssessmentInputs(
            inputControllers: controller.selfAssessmentPairs,
            onRemoveInputGroup: controller.removeSelfAssessmentPair,
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
          CreateInput(
            label: 'Full title',
            controller: controller.titleController,
          ),
          const SizedBox(height: 24),
          controller.mode.buildInputs(controller),
          ModeSelect(controller: controller),
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

class ModeSelect extends StatelessWidget {
  final CreateController controller;

  const ModeSelect({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<PracticeMode>(
      value: controller.mode,
      onChanged: (mode) {
        if (mode != null) controller.updateMode(mode);
      },
      items: PracticeMode.values.map((mode) {
        return DropdownMenuItem(
          value: mode,
          child: Text(mode.label),
        );
      }).toList(),
    );
  }
}
