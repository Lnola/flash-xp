import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isBlock;

  const FlashButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isBlock = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: isBlock ? 16 : 8,
        ),
        shape: const StadiumBorder(),
        textStyle: Theme.of(context).textTheme.labelMedium,
      ),
      child: Text(label),
    );

    return isBlock
        ? SizedBox(width: double.infinity, child: button)
        : Align(alignment: Alignment.center, child: button);
  }
}
