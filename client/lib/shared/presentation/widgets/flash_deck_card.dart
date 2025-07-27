import 'package:flashxp/router.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_client_label.extension.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

extension on PracticeMode {
  IconData get icon => switch (this) {
        PracticeMode.multipleChoice => FontAwesomeIcons.listOl,
        PracticeMode.selfAssessment => FontAwesomeIcons.solidThumbsUp,
      };
}

class FlashDeckCard extends StatelessWidget {
  final int deckId;
  final String title;
  final int totalQuestions;
  final int progress;
  final PracticeMode mode;
  final Color? backgroundColor;
  final double width;

  const FlashDeckCard({
    super.key,
    required this.deckId,
    required this.title,
    required this.totalQuestions,
    required this.progress,
    required this.mode,
    this.backgroundColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () => context.push(
          '/home/preview',
          extra: RouterStateExtra(title: title),
        ),
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
      ),
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
  final PracticeMode mode;

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
          onPressed: () => context.push('/home/practice'),
        ),
        Text('$progress%', style: theme.textTheme.bodySmall),
      ],
    );
  }
}
