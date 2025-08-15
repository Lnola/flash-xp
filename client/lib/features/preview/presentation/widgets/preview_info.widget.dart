import 'package:flashxp/shared/presentation/widgets/utils/if.dart';
import 'package:flutter/material.dart';

class PreviewInfoWidget extends StatelessWidget {
  final String label;
  final String content;
  final int? boxIndex;

  const PreviewInfoWidget({
    super.key,
    required this.label,
    required this.content,
    this.boxIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 24,
        children: [
          Expanded(
            child: _QuestionInfo(label: label, content: content),
          ),
          If(
            condition: boxIndex != null,
            child: _BoxIndex(boxIndex: boxIndex),
          ),
        ],
      ),
    );
  }
}

class _QuestionInfo extends StatelessWidget {
  final String label;
  final String content;

  const _QuestionInfo({
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withAlpha(77),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.2),
        ),
      ],
    );
  }
}

class _BoxIndex extends StatelessWidget {
  final int? boxIndex;

  const _BoxIndex({
    required this.boxIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$boxIndex',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSecondary,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
