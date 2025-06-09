import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isBlock;
  final bool isSecondary;

  const FlashButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isBlock = false,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSecondary
        ? Colors.transparent
        : Theme.of(context).colorScheme.primaryContainer;
    final foregroundColor = isSecondary
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.onPrimaryContainer;

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: isBlock ? 16 : 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 2,
          ),
        ),
        textStyle: Theme.of(context).textTheme.labelMedium,
      ),
      child: Text(label),
    );

    return isBlock
        ? SizedBox(width: double.infinity, child: button)
        : Align(alignment: Alignment.center, child: button);
  }
}
