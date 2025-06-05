import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/data/question.repository.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode_multiple_choice.strategy.dart';
import 'package:flashxp/features/practice/logic/model/answer_option_button.model.dart';
import 'package:flutter/material.dart';

class PracticeController extends ChangeNotifier {
  final QuestionRepository _questionRepository;
  bool hasAnswered = false;
  late PracticeModeStrategy modeStrategy;
  late String question;
  late String? answer;
  late List<AnswerOptionButtonModel> answerOptionButtons;
  bool isLoading = true;

  PracticeController(this._questionRepository) {
    modeStrategy = MultipleChoiceStrategy();
    initQuestion();
  }

  Future<void> initQuestion() async {
    hasAnswered = false;
    isLoading = true;

    final fetched = await _questionRepository.fetchQuestion();
    final dummyQuestion =
        'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
    final dummyAnswer =
        'Answer is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

    final dummyAnswerOptionDtos = [
      AnswerOptionDto(label: 'A', isCorrect: false),
      AnswerOptionDto(label: 'B', isCorrect: false),
      AnswerOptionDto(label: 'C', isCorrect: true),
      AnswerOptionDto(label: 'D', isCorrect: false),
    ];

    question = dummyQuestion;
    answer = dummyAnswer;
    answerOptionButtons = modeStrategy.createAnswerOptionButtons(
      onPressed: _handleOptionSelected,
      answerOptionDtos: dummyAnswerOptionDtos,
    );

    isLoading = false;
    notifyListeners();
  }

  void nextQuestion() => initQuestion();

  void _handleOptionSelected(String label) {
    hasAnswered = true;
    answerOptionButtons = modeStrategy.updateAnswerOptionButtons(
      label: label,
      answerOptionButtons: answerOptionButtons,
    );
    notifyListeners();
  }
}
