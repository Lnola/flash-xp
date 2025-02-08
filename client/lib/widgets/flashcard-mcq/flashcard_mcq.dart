import 'package:flutter/material.dart';

import 'option_list.dart';
import 'question.dart';

class FlashcardMcq extends StatelessWidget {
  final String question;
  final List<String> options;
  final String correctOption;
  final VoidCallback onNext;

  const FlashcardMcq({
    super.key,
    required this.question,
    required this.options,
    required this.correctOption,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Question(question: question),
            SizedBox(height: 16),
            OptionList(
              options: options,
              correctOption: correctOption,
              onNext: onNext,
            ),
          ],
        ),
      ),
    );
  }
}
