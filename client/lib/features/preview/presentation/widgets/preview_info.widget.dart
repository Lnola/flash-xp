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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(28),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
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
              ),
            ),
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

class _BoxIndex extends StatelessWidget {
  final int? boxIndex;

  const _BoxIndex({
    required this.boxIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(
        '$boxIndex',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(77),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
