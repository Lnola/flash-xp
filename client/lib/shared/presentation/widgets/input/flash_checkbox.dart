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
    final checkbox = Checkbox(
      value: value,
      onChanged: onChanged,
    );

    if (label == null) return checkbox;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Text(label!, style: Theme.of(context).textTheme.bodySmall),
        checkbox,
      ],
    );
  }
}
