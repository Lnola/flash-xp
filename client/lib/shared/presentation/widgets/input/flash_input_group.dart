import 'package:flashxp/features/create/presentation/create.view.dart';
import 'package:flashxp/shared/presentation/widgets/utils/if.dart';
import 'package:flutter/material.dart';

class FlashInputGroup<T> extends StatelessWidget {
  final List<T> inputControllers;
  final void Function(T) onRemoveInputGroup;
  final bool Function(T input) isDirty;
  final List<Widget> Function(T input) buildChildren;

  const FlashInputGroup({
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(children: buildChildren(input))),
              If(
                condition: true,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _handleRemoveTap(context, input),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
