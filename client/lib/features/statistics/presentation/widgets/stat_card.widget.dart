import 'package:flutter/material.dart';

class StatCardWidget extends StatelessWidget {
  final String value;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  const StatCardWidget({
    super.key,
    required this.value,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = this.textColor ?? Theme.of(context).colorScheme.onSurface;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: textColor,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: textColor.withAlpha(77),
                ),
          ),
        ],
      ),
    );
  }
}
