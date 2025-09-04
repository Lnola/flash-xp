import 'package:flashxp/shared/presentation/widgets/utils/flip_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PracticeQuestion extends StatelessWidget {
  final String question;
  final String? answer;
  final bool isAnswerShown;
  final Function() toggleIsAnswerShown;

  const PracticeQuestion({
    super.key,
    required this.question,
    this.answer,
    required this.isAnswerShown,
    required this.toggleIsAnswerShown,
  });
  @override
  Widget build(BuildContext context) {
    final isAnswerAvailable = answer != null;

    final front = _QuestionCardSide(
      title: isAnswerAvailable ? 'Question' : null,
      body: question,
      onTap: isAnswerAvailable ? toggleIsAnswerShown : null,
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
    );

    if (!isAnswerAvailable) return front;

    final back = _QuestionCardSide(
      title: 'Answer',
      body: answer!,
      onTap: toggleIsAnswerShown,
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
    );

    return FlipContent(
      flipped: isAnswerShown,
      front: front,
      back: back,
    );
  }
}

class _QuestionCardSide extends StatelessWidget {
  final String body;
  final String? title;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const _QuestionCardSide({
    required this.body,
    this.title,
    this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final widget = SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(56),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 24,
          children: [
            title != null ? _CardTitle(label: title!) : const Spacer(),
            _CardBody(label: body),
            onTap != null ? const _CardRotateButton() : const Spacer(),
          ],
        ),
      ),
    );
    if (onTap == null) return widget;
    return InkWell(
      onTap: onTap!,
      child: widget,
    );
  }
}

class _CardTitle extends StatelessWidget {
  final String label;

  const _CardTitle({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class _CardBody extends StatelessWidget {
  final String label;

  const _CardBody({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class _CardRotateButton extends StatelessWidget {
  const _CardRotateButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Tap to rotate card',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
              ),
        ),
        const SizedBox(width: 8),
        FaIcon(
          FontAwesomeIcons.rotate,
          size: 14,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
        ),
      ],
    );
  }
}
