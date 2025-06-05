import 'package:flashxp/widgets/utils/flip_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PracticeQuestion extends StatefulWidget {
  final String question;
  final String? answer;

  const PracticeQuestion({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  State<PracticeQuestion> createState() => _PracticeQuestionState();
}

class _PracticeQuestionState extends State<PracticeQuestion> {
  bool _isAnswerShown = false;

  void _toggleIsAnswerShown() {
    setState(() {
      _isAnswerShown = !_isAnswerShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String question = widget.question;
    final String? answer = widget.answer;
    final isAnswerAvailable = answer != null;

    final front = _buildCardSide(
      context,
      title: isAnswerAvailable ? 'Question' : null,
      body: question,
      onTap: isAnswerAvailable ? _toggleIsAnswerShown : null,
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
    );

    if (!isAnswerAvailable) return front;

    final back = _buildCardSide(
      context,
      title: 'Answer',
      body: answer,
      onTap: _toggleIsAnswerShown,
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
    );

    return Expanded(
      child: FlipContent(
        flipped: _isAnswerShown,
        front: front,
        back: back,
      ),
    );
  }

  Widget _buildCardSide(
    BuildContext context, {
    required String body,
    String? title,
    VoidCallback? onTap,
    required Color backgroundColor,
  }) {
    return Expanded(
      child: SizedBox(
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
              title != null ? _QuestionTitle(label: title) : const Spacer(),
              _QuestionBody(label: body),
              onTap != null
                  ? _QuestionRotateButton(onTap: onTap)
                  : const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionTitle extends StatelessWidget {
  final String label;

  const _QuestionTitle({
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

class _QuestionBody extends StatelessWidget {
  final String label;

  const _QuestionBody({
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

class _QuestionRotateButton extends StatelessWidget {
  final VoidCallback onTap;

  const _QuestionRotateButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
