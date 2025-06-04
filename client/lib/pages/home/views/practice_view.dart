import 'package:flashxp/pages/home/widgets/practice/practice_option_list.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_progress.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_question.dart';
import 'package:flashxp/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';

class PracticeView extends StatelessWidget {
  const PracticeView({super.key});

  @override
  Widget build(BuildContext context) {
    final question =
        'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
    final answer =
        'Answer is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          const PracticeProgress(current: 3, total: 12),
          const SizedBox(height: 16),
          PracticeQuestion(question: question, answer: answer),
          const SizedBox(height: 24),
          const PracticeOptionList(),
          const SizedBox(height: 44),
          FlashButton(
            onPressed: () {},
            label: 'Next Question',
            isBlock: true,
          ),
        ],
      ),
    );
  }
}
