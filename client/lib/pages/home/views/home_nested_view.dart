import 'package:flashxp/widgets/flashcard-mcq/flashcard_mcq.dart';
import 'package:flutter/material.dart';

class PracticeView extends StatelessWidget {
  const PracticeView({super.key});

  @override
  Widget build(BuildContext context) {
    final question = 'What is the spanish word for apple?';
    final options = ['Manzana', 'Naranja', 'Plátano', 'Fresa'];
    final correctOption = 'Manzana';

    void getNextQuestion() {}

    return Center(
      child: FlashcardMcq(
        question: question,
        options: options,
        correctOption: correctOption,
        onNext: getNextQuestion,
      ),
    );
  }
}
