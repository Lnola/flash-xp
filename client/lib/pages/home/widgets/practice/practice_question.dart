import 'package:flashxp/widgets/utils/flip_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PracticeQuestion extends StatefulWidget {
  final String question;
  final String answer;

  const PracticeQuestion({
    super.key,
    required this.question,
    required this.answer,
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
    final String answer = widget.answer;

    return FlipContent(
      flipped: _isAnswerShown,
      front: _buildCardSide(
        context,
        title: 'Question',
        body: question,
        onTap: _toggleIsAnswerShown,
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      ),
      back: _buildCardSide(
        context,
        title: 'Answer',
        body: answer,
        onTap: _toggleIsAnswerShown,
        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      ),
    );
  }

  Widget _buildCardSide(
    BuildContext context, {
    required String title,
    required String body,
    required VoidCallback onTap,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(56),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuestionTitle(label: title),
          QuestionBody(label: body),
          QuestionRotateButton(onTap: onTap),
        ],
      ),
    );
  }
}

class QuestionTitle extends StatelessWidget {
  final String label;

  const QuestionTitle({
    super.key,
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

class QuestionBody extends StatelessWidget {
  final String label;

  const QuestionBody({
    super.key,
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

class QuestionRotateButton extends StatelessWidget {
  final VoidCallback onTap;

  const QuestionRotateButton({
    super.key,
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
