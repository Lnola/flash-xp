import 'package:flashxp/features/practice/data/dto/question.dto.dart';
import 'package:flashxp/features/practice/data/question.repository.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode_multiple_choice.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode_self_assessment.strategy.dart';
import 'package:flashxp/features/practice/logic/model/answer_option_button.model.dart';
import 'package:flutter/material.dart';

class PracticeController extends ChangeNotifier {
  final QuestionRepository _questionRepository;
  late PracticeModeStrategy modeStrategy;

  late String question;
  late String? answer;
  late List<AnswerOptionButtonModel> answerOptionButtons;
  late int totalQuestions;

  bool hasAnswered = false;
  bool isLoading = true;

  List<QuestionDto> _questions = [];
  int _currentQuestionIndex = 0;

  int get currentQuestionIndex => _currentQuestionIndex + 1;

  PracticeController(this._questionRepository) {
    initQuestions();
  }

  Future<void> initQuestions() async {
    isLoading = true;

    _questions = await _questionRepository.fetch();
    if (_questions.isEmpty) return;

    totalQuestions = _questions.length;
    _currentQuestionIndex = 0;
    modeStrategy = _resolveStrategy(_questions.first);

    _loadCurrentQuestion();
    isLoading = false;
  }

  PracticeModeStrategy _resolveStrategy(QuestionDto question) {
    final options = question.answerOptionDtos;
    final hasOptions = options != null && options.isNotEmpty;
    return hasOptions ? MultipleChoiceStrategy() : SelfAssessmentStrategy();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < totalQuestions - 1) {
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
