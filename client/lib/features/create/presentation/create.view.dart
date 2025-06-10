import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/widgets/create_input.widget.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

extension PracticeModeUIX on PracticeMode {
  String get label {
    switch (this) {
      case PracticeMode.selfAssessment:
        return 'Self Assessment';
      case PracticeMode.multipleChoice:
        return 'Multiple Choice';
    }
  }

  Widget buildInputs(CreateController controller) {
    switch (this) {
      case PracticeMode.selfAssessment:
        return SelfAssessmentInputs(controller: controller);
      case PracticeMode.multipleChoice:
        return MultipleChoiceInputs(controller: controller);
    }
  }

  void handleAddInput(CreateController controller) {
    switch (this) {
      case PracticeMode.multipleChoice:
        controller.addMultipleChoiceQuestion();
        break;
      case PracticeMode.selfAssessment:
        controller.addDynamicInput();
        break;
    }
  }
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

class SelfAssessmentInputs extends StatelessWidget {
  final CreateController controller;

  const SelfAssessmentInputs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.selfAssessmentPairs.map((pair) {
        final isDirty =
            pair.$1.text.trim().isNotEmpty || pair.$2.text.trim().isNotEmpty;
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    CreateInput(label: 'Question', controller: pair.$1),
                    const SizedBox(height: 8),
                    CreateInput(label: 'Answer', controller: pair.$2),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  if (isDirty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Remove Pair'),
                        content: const Text(
                          'Are you sure you want to remove this question-answer pair?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.removeSelfAssessmentPair(pair);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    controller.removeSelfAssessmentPair(pair);
                  }
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class MultipleChoiceInputs extends StatelessWidget {
  final CreateController controller;

  const MultipleChoiceInputs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.multipleChoiceQuestions.map((question) {
        final isDirty = question.$1.text.isNotEmpty ||
            question.$2.any((c) => c.text.isNotEmpty);
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
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
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  if (isDirty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Remove Question'),
                        content: const Text(
                          'Some fields are not empty. Are you sure you want to remove this question?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.removeMultipleChoiceQuestion(question);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    controller.removeMultipleChoiceQuestion(question);
                  }
                },
              ),
            ],
          ),
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
