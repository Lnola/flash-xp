import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PracticeQuestion extends StatelessWidget {
  final String question;
  final String? answer;

  const PracticeQuestion({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(56),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const QuestionTitle(),
          Text(
            question,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const QuestionRotateButton(),
        ],
      ),
    );
  }
}

class QuestionRotateButton extends StatelessWidget {
  const QuestionRotateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
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
      ),
    );
  }
}

class QuestionTitle extends StatelessWidget {
  const QuestionTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Question',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
