import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/widgets/create_input.widget.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
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
        PracticeMode.multipleChoice =>
          MultipleChoiceInputs(controller: controller),
        PracticeMode.selfAssessment =>
          SelfAssessmentInputs(controller: controller),
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

class RemovableInputGroup extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onRemove;

  const RemovableInputGroup({
    super.key,
    required this.children,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(children: children),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class SelfAssessmentInputs extends StatelessWidget {
  final CreateController controller;

  const SelfAssessmentInputs({super.key, required this.controller});

  void _handleRemoveTap(
    bool isDirty,
    BuildContext context,
    (TextEditingController, TextEditingController) pair,
  ) async {
    if (isDirty) {
      final shouldDelete = await showConfirmDeleteDialog(context);
      if (shouldDelete) {
        controller.removeSelfAssessmentPair(pair);
      }
    } else {
      controller.removeSelfAssessmentPair(pair);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.selfAssessmentPairs.map((pair) {
        final isDirty =
            pair.$1.text.trim().isNotEmpty || pair.$2.text.trim().isNotEmpty;
        return RemovableInputGroup(
          onRemove: () => _handleRemoveTap(isDirty, context, pair),
          children: [
            CreateInput(label: 'Question', controller: pair.$1),
            const SizedBox(height: 8),
            CreateInput(label: 'Answer', controller: pair.$2),
          ],
        );
      }).toList(),
    );
  }
}

class MultipleChoiceInputs extends StatelessWidget {
  final CreateController controller;

  const MultipleChoiceInputs({super.key, required this.controller});

  void _handleRemoveTap(
    bool isDirty,
    BuildContext context,
    (TextEditingController, List<TextEditingController>) question,
  ) async {
    if (isDirty) {
      final shouldDelete = await showConfirmDeleteDialog(context);
      if (shouldDelete) {
        controller.removeMultipleChoiceQuestion(question);
      }
    } else {
      controller.removeMultipleChoiceQuestion(question);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.multipleChoiceQuestions.map((question) {
        final isDirty = question.$1.text.isNotEmpty ||
            question.$2.any((c) => c.text.isNotEmpty);
        return RemovableInputGroup(
          onRemove: () => _handleRemoveTap(isDirty, context, question),
          children: [
            CreateInput(label: 'Question', controller: question.$1),
            const SizedBox(height: 8),
            for (var i = 0; i < 4; i++) ...[
              CreateInput(
                label: 'Option ${String.fromCharCode(65 + i)}',
                controller: question.$2[i],
              ),
              const SizedBox(height: 8),
            ],
          ],
        );
      }).toList(),
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
