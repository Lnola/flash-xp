import 'package:flashxp/shared/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlashCard extends StatelessWidget {
  final String title;
  final int totalQuestions;
  final int progress;
  final Color? backgroundColor;

  const FlashCard({
    super.key,
    required this.title,
    required this.totalQuestions,
    required this.progress,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 216,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CardInfo(
            theme: theme,
            title: title,
            totalQuestions: totalQuestions,
          ),
          _CardActions(
            theme: theme,
            progress: progress,
          ),
        ],
      ),
    );
  }
}

class _CardInfo extends StatelessWidget {
  final String title;
  final int totalQuestions;

  const _CardInfo({
    required this.theme,
    required this.title,
    required this.totalQuestions,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(height: 1.2),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const FaIcon(FontAwesomeIcons.solidCircleQuestion, size: 16),
            const SizedBox(width: 8),
            Text(
              '$totalQuestions Questions',
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const FaIcon(FontAwesomeIcons.listOl, size: 16),
            const SizedBox(width: 8),
            Text('Multiple Choice', style: theme.textTheme.labelMedium),
          ],
        ),
      ],
    );
  }
}

class _CardActions extends StatelessWidget {
  final int progress;

  const _CardActions({
    required this.theme,
    required this.progress,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlashButton(label: 'Start now', onPressed: () {}),
        Text('$progress%', style: theme.textTheme.bodySmall),
      ],
    );
  }
}
