import 'package:flutter/material.dart';

class FlashProgressBar extends StatelessWidget {
  final double progress;

  const FlashProgressBar({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      minHeight: 12,
      borderRadius: BorderRadius.circular(12),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      color: Theme.of(context).colorScheme.onInverseSurface,
    );
  }
}
