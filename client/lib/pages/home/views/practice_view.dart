import 'package:flashxp/state/navigation_state.dart';
import 'package:flashxp/widgets/flashcard-mcq/flashcard_mcq.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PracticeView extends StatelessWidget {
  const PracticeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigationState = context.read<NavigationState>();
      navigationState.setTitle('Practice');
      navigationState.setShowBackButton(true);
    });

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
