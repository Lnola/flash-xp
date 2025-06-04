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

  void _toggleAnswer() {
    setState(() {
      _isAnswerShown = !_isAnswerShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasAnswer = widget.answer != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(56),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasAnswer)
            QuestionTitle(label: _isAnswerShown ? 'Answer' : 'Question')
          else
            const Spacer(),
          QuestionBody(
            label: _isAnswerShown ? widget.answer! : widget.question,
          ),
          if (hasAnswer)
            QuestionRotateButton(onTap: _toggleAnswer)
          else
            const Spacer(),
        ],
      ),
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
