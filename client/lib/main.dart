import 'package:flutter/material.dart';

import 'widgets/flashcard-mcq/flashcard_mcq.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var question = 'What is the spanish word for apple?';
    var options = ['Manzana', 'Naranja', 'Plátano', 'Fresa'];
    var correctOption = 'Manzana';

    void getNextQuestion() {}

    return MaterialApp(
      title: "flash-xp",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: Scaffold(
        body: Center(
          child: FlashcardMcq(
            question: question,
            options: options,
            correctOption: correctOption,
            onNext: getNextQuestion,
          ),
        ),
      ),
    );
  }
}
