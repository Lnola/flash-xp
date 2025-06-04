import 'package:flashxp/pages/home/widgets/practice/practice_option_button.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_option_list.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_progress.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_question.dart';
import 'package:flashxp/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PracticeView extends StatefulWidget {
  const PracticeView({super.key});

  @override
  State<PracticeView> createState() => _PracticeViewState();
}

class _PracticeViewState extends State<PracticeView> {
  bool _hasAnswered = false;

  @override
  Widget build(BuildContext context) {
    final question =
        'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
    final answer =
        'Answer is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

    final List<OptionButtonData> options = [
      OptionButtonData(
        label: "I don't know",
        onPressed: () => setState(() => _hasAnswered = true),
        state: PracticeOptionState.incorrect,
      ),
      OptionButtonData(
        label: 'I know',
        onPressed: () => setState(() => _hasAnswered = true),
        state: PracticeOptionState.correct,
      ),
    ];

    void handleNextQuestion() {
      // TODO: implement logic to fetch the next question
      setState(() {
        _hasAnswered = false;
      });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 18),
      child: Column(
        children: [
          const PracticeProgress(current: 3, total: 12),
          const SizedBox(height: 16),
          PracticeQuestion(question: question, answer: answer),
          const SizedBox(height: 24),
          PracticeOptionList(options: options),
          const SizedBox(height: 44),
          FlashButton(
            onPressed: _hasAnswered ? handleNextQuestion : () {},
            label: 'Next Question',
            isBlock: true,
          )
              .animate(target: _hasAnswered ? 1 : 0)
              .fade(begin: 0, end: 1, duration: 150.ms)
              .slideY(begin: 1, end: 0, duration: 150.ms),
        ],
      ),
    );
  }
}
