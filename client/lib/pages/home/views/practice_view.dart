import 'package:flashxp/state/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flashxp/widgets/flashcard-mcq/flashcard_mcq.dart';
import 'package:provider/provider.dart';

class PracticeView extends StatelessWidget {
  const PracticeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavigationState>().setTitle('Practice');
    });

    var question = 'What is the spanish word for apple?';
    var options = ['Manzana', 'Naranja', 'Plátano', 'Fresa'];
    var correctOption = 'Manzana';

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
