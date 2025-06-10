import 'package:flashxp/features/create/presentation/create.view.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_input_group.dart';
import 'package:flutter/material.dart';

class FlashModeInputGroup<T> extends StatelessWidget {
  final List<T> inputControllers;
  final void Function(T) onRemoveInputGroup;
  final bool Function(T input) isDirty;
  final List<Widget> Function(T input) buildChildren;

  const FlashModeInputGroup({
    super.key,
    required this.inputControllers,
    required this.onRemoveInputGroup,
    required this.isDirty,
    required this.buildChildren,
  });

  void _handleRemoveTap(BuildContext context, T input) async {
    final dirty = isDirty(input);
    if (dirty) {
      final shouldDelete = await showConfirmDeleteDialog(context);
      if (shouldDelete) {
        onRemoveInputGroup(input);
      }
    } else {
      onRemoveInputGroup(input);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: inputControllers.map((input) {
        return FlashInputGroup(
          onRemove: () => _handleRemoveTap(context, input),
          children: buildChildren(input),
        );
      }).toList(),
    );
  }
}
