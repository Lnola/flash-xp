import 'package:flashxp/features/practice/data/dto/question.dto.dart';
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

  List<QuestionDto> _questions = [];
  int _currentQuestionIndex = 0;

  PracticeController(this._questionRepository) {
    modeStrategy = MultipleChoiceStrategy();
    initQuestions();
  }

  Future<void> initQuestions() async {
    isLoading = true;

    _questions = await _questionRepository.fetch();
    _currentQuestionIndex = 0;

    _loadCurrentQuestion();

    isLoading = false;
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _loadCurrentQuestion();
    }
  }

  void _loadCurrentQuestion() {
    hasAnswered = false;

    final current = _questions[_currentQuestionIndex];
    question = current.text;
    answer = current.answer;
    answerOptionButtons = modeStrategy.createAnswerOptionButtons(
      onPressed: _handleOptionSelected,
      answerOptionDtos: current.answerOptionDtos,
    );
    notifyListeners();
  }

  void _handleOptionSelected(String label) {
    hasAnswered = true;
    answerOptionButtons = modeStrategy.updateAnswerOptionButtons(
      label: label,
      answerOptionButtons: answerOptionButtons,
    );
    notifyListeners();
  }
}
