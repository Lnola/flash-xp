import 'package:flutter/material.dart';
import 'package:flashxp/widgets/flashcard-mcq/flashcard_mcq.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var question = 'What is the spanish word for apple?';
    var options = ['Manzana', 'Naranja', 'Plátano', 'Fresa'];
    var correctOption = 'Manzana';

    void getNextQuestion() {}

    return Scaffold(
      body: Center(
        child: FlashcardMcq(
          question: question,
          options: options,
          correctOption: correctOption,
          onNext: getNextQuestion,
        ),
      ),
    );
  }
}
