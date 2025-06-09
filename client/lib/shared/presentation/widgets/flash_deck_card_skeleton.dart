import 'package:flutter/material.dart';

class FlashDeckCardSkeleton extends StatelessWidget {
  final double width;

  const FlashDeckCardSkeleton({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget skeletonBox({double? height, double? width, bool rounded = false}) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withAlpha(33),
          borderRadius:
              rounded ? BorderRadius.circular(1000) : BorderRadius.circular(8),
        ),
      );
    }

    return Container(
      width: width,
      height: 216,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              skeletonBox(height: 24, width: width * 0.7),
              const SizedBox(height: 12),
              skeletonBox(height: 16, width: width * 0.75),
              const SizedBox(height: 8),
              skeletonBox(height: 16, width: width * 0.8),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                skeletonBox(height: 40, width: width * 0.5, rounded: true),
                skeletonBox(height: 16, width: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
