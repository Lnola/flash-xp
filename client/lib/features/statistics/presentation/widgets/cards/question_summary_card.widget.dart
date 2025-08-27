import 'package:flashxp/router.dart';
import 'package:flashxp/shared/presentation/widgets/flash_skeleton_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuestionSummaryCardWidget extends StatelessWidget {
  final String text;
  final int deckId;
  final String deckTitle;
  final int? prefixNumber;

  const QuestionSummaryCardWidget({
    super.key,
    required this.text,
    required this.deckId,
    required this.deckTitle,
    this.prefixNumber,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => context.push(
        '/home/$deckId/preview',
        extra: RouterStateExtra(title: deckTitle),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _PrefixNumber(prefixNumber: prefixNumber),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deckTitle,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(99),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(text, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrefixNumber extends StatelessWidget {
  final int? prefixNumber;

  const _PrefixNumber({this.prefixNumber});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withAlpha(99),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 36,
      height: 40,
      alignment: Alignment.center,
      child: Text(
        prefixNumber.toString(),
        style: theme.textTheme.titleSmall,
      ),
    );
  }
}

class QuestionSummaryCardSkeleton extends StatelessWidget {
  const QuestionSummaryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          FlashSkeletonBox(width: 36, height: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlashSkeletonBox(height: 16, width: 140),
                SizedBox(height: 8),
                FlashSkeletonBox(height: 12),
                SizedBox(height: 6),
                FlashSkeletonBox(height: 12, width: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
