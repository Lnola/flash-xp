import 'package:flutter/material.dart';

class FlashDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> values;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;

  const FlashDropdown({
    super.key,
    required this.value,
    required this.values,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      onChanged: onChanged,
      items: values.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(labelBuilder(item)),
        );
      }).toList(),
    );
  }
}
