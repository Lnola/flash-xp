import 'package:flashxp/features/create/presentation/create.view.dart';
import 'package:flashxp/features/create/presentation/widgets/create_input.widget.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flutter/material.dart';

class MultipleChoiceInputs extends StatelessWidget {
  final List<(TextEditingController, List<TextEditingController>)>
      inputControllers;
  final void Function((TextEditingController, List<TextEditingController>))
      onRemoveInputGroup;

  const MultipleChoiceInputs({
    super.key,
    required this.inputControllers,
    required this.onRemoveInputGroup,
  });

  void _handleRemoveTap(
    bool isDirty,
    BuildContext context,
    (TextEditingController, List<TextEditingController>) question,
  ) async {
    if (isDirty) {
      final shouldDelete = await showConfirmDeleteDialog(context);
      if (shouldDelete) {
        onRemoveInputGroup(question);
      }
    } else {
      onRemoveInputGroup(question);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: inputControllers.map((question) {
        final isDirty = question.$1.text.isNotEmpty ||
            question.$2.any((c) => c.text.isNotEmpty);
        return FlashInputGroup(
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

class SelfAssessmentInputs extends StatelessWidget {
  final List<(TextEditingController, TextEditingController)> inputControllers;
  final void Function((TextEditingController, TextEditingController))
      onRemoveInputGroup;

  const SelfAssessmentInputs({
    super.key,
    required this.inputControllers,
    required this.onRemoveInputGroup,
  });

  void _handleRemoveTap(
    bool isDirty,
    BuildContext context,
    (TextEditingController, TextEditingController) pair,
  ) async {
    if (isDirty) {
      final shouldDelete = await showConfirmDeleteDialog(context);
      if (shouldDelete) {
        onRemoveInputGroup(pair);
      }
    } else {
      onRemoveInputGroup(pair);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: inputControllers.map((pair) {
        final isDirty =
            pair.$1.text.trim().isNotEmpty || pair.$2.text.trim().isNotEmpty;
        return FlashInputGroup(
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
