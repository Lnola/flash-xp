import 'package:flutter/material.dart';

class FlashSkeletonBox extends StatelessWidget {
  final double? height;
  final double? width;
  final bool rounded;

  const FlashSkeletonBox({
    super.key,
    this.height,
    this.width,
    this.rounded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(33),
        borderRadius:
            rounded ? BorderRadius.circular(1000) : BorderRadius.circular(8),
      ),
    );
  }
}
