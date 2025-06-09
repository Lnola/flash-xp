import 'package:flutter/material.dart';

class FlashLoading extends StatelessWidget {
  const FlashLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
