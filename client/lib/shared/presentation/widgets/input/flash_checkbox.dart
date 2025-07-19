import 'package:flutter/material.dart';

class FlashCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? label;

  const FlashCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final checkbox = Checkbox(
      value: value,
      onChanged: onChanged,
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return theme.colorScheme.tertiary;
          }
          return theme.colorScheme.error;
        },
      ),
      side: BorderSide(
        color: theme.colorScheme.outline.withAlpha(77),
        width: 1.5,
      ),
    );

    if (label == null) return checkbox;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Text(label!, style: theme.textTheme.bodySmall),
        checkbox,
      ],
    );
  }
}
