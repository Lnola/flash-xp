import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const FlashButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: const StadiumBorder(),
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
      child: Text(label),
    );
  }
}
