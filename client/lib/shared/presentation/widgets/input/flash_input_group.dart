import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<bool> showConfirmRemoveDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Remove question',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        'Are you sure you want to remove this question?',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'Remove',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    ),
  );
  return result ?? false;
}

class FlashInputGroup<T> extends StatelessWidget {
  final List<T> inputControllers;
  final void Function(T) onRemoveInputGroup;
  final bool Function(T input) isDirty;
  final List<Widget> Function(T input) buildInputs;

  const FlashInputGroup({
    super.key,
    required this.inputControllers,
    required this.onRemoveInputGroup,
    required this.isDirty,
    required this.buildInputs,
  });

  void _handleRemovePressed(BuildContext context, T input) async {
    if (!isDirty(input)) {
      onRemoveInputGroup(input);
      return;
    }
    final isConfirmed = await showConfirmRemoveDialog(context);
    if (isConfirmed) {
      onRemoveInputGroup(input);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: inputControllers.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final input = entry.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            _InputGroupHeader(
              index: index,
              handleRemovePressed: () => _handleRemovePressed(context, input),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    spacing: 8,
                    children: buildInputs(input),
                  ),
                ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _InputGroupHeader extends StatelessWidget {
  final int index;
  final VoidCallback handleRemovePressed;

  const _InputGroupHeader({
    required this.index,
    required this.handleRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Question #$index',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.trash, size: 18),
          onPressed: handleRemovePressed,
        ),
      ],
    );
  }
}
