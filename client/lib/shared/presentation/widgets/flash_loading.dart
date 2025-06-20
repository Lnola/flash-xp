import 'package:flutter/material.dart';

class FlashLoading extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const FlashLoading({
    super.key,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40,
      width: width ?? 40,
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
