import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode_multiple_choice.strategy.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_list.dart';
import 'package:flutter/material.dart';

class PracticeController extends ChangeNotifier {
  bool hasAnswered = false;
  late String question;
  late String answer;
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
    final dummyQuestion =
        'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
    final dummyAnswer =
        'Answer is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

    final dummyOptions = [
      AnswerOption(label: 'A', isCorrect: false),
      AnswerOption(label: 'B', isCorrect: false),
      AnswerOption(label: 'C', isCorrect: true),
      AnswerOption(label: 'D', isCorrect: false),
    ];

    hasAnswered = false;
    question = dummyQuestion;
    answer = dummyAnswer;
    options = modeStrategy.createOptions(
      onPressed: _handleOptionSelected,
      answerOptions: dummyOptions,
    );
    notifyListeners();
  }

  void nextQuestion() => initQuestion();
}
