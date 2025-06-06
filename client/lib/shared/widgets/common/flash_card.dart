import 'package:flashxp/shared/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

// TODO: extract this enum and leverage it for the practice feature as well
enum FlashCardMode { multipleChoice, selfAssessment }

extension on FlashCardMode {
  IconData get icon => switch (this) {
        FlashCardMode.multipleChoice => FontAwesomeIcons.listOl,
        FlashCardMode.selfAssessment => FontAwesomeIcons.solidThumbsUp,
      };

  String get label => switch (this) {
        FlashCardMode.multipleChoice => 'Multiple Choice',
        FlashCardMode.selfAssessment => 'Flashcards',
      };
}

class FlashCard extends StatelessWidget {
  final String title;
  final int totalQuestions;
  final int progress;
  final FlashCardMode mode;
  final Color? backgroundColor;

  const FlashCard({
    super.key,
    required this.title,
    required this.totalQuestions,
    required this.progress,
    required this.mode,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: (constraints.maxWidth / 2) - 6,
          child: Container(
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
                  title: title,
                  totalQuestions: totalQuestions,
                  mode: mode,
                ),
                _CardActions(progress: progress),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CardInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _CardInfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        FaIcon(icon, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.labelMedium,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
      ],
    );
  }
}

class _CardInfo extends StatelessWidget {
  final String title;
  final int totalQuestions;
  final FlashCardMode mode;

  const _CardInfo({
    required this.title,
    required this.totalQuestions,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(height: 1.2),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        _CardInfoRow(
          icon: FontAwesomeIcons.solidCircleQuestion,
          text: '$totalQuestions Questions',
        ),
        const SizedBox(height: 4),
        _CardInfoRow(icon: mode.icon, text: mode.label),
      ],
    );
  }
}

class _CardActions extends StatelessWidget {
  final int progress;

  const _CardActions({
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlashButton(
          label: 'Start now',
          onPressed: () => context.go('/home/practice'),
        ),
        Text('$progress%', style: theme.textTheme.bodySmall),
      ],
    );
  }
}
