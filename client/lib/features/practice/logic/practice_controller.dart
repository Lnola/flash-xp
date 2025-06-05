import 'package:flashxp/features/practice/data/dto/answer_option_dto.dart';
import 'package:flashxp/features/practice/logic/practice_mode_strategy.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_list.dart';
import 'package:flutter/material.dart';

class PracticeController extends ChangeNotifier {
  bool hasAnswered = false;
  late PracticeModeStrategy modeStrategy;
  late List<OptionButtonData> options;

  PracticeController() {
    modeStrategy = MultipleChoiceStrategy();
    initQuestion();
  }

  void _handleOptionSelected(String label) {
    hasAnswered = true;
    options = modeStrategy.updateOptions(label: label, options: options);
    notifyListeners();
  }

  void initQuestion() {
    final dummyOptions = [
      AnswerOption(label: 'A', isCorrect: false),
      AnswerOption(label: 'B', isCorrect: false),
      AnswerOption(label: 'C', isCorrect: true),
      AnswerOption(label: 'D', isCorrect: false),
    ];

    hasAnswered = false;
    options = modeStrategy.createOptions(
      onPressed: _handleOptionSelected,
      answerOptions: dummyOptions,
    );
    notifyListeners();
  }

  void nextQuestion() => initQuestion();
}
