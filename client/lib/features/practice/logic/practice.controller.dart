import 'package:flashxp/features/practice/data/dto/question.dto.dart';
import 'package:flashxp/features/practice/data/question.repository.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode_multiple_choice.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode_self_assessment.strategy.dart';
import 'package:flashxp/features/practice/logic/model/answer_option_button.model.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

extension on PracticeMode {
  PracticeModeStrategy get strategy => switch (this) {
        PracticeMode.multipleChoice => MultipleChoiceStrategy(),
        PracticeMode.selfAssessment => SelfAssessmentStrategy(),
      };
}

class PracticeController extends ChangeNotifier {
  final QuestionRepository _questionRepository;
  late PracticeMode mode;

  late String question;
  late String? answer;
  late List<AnswerOptionButtonModel> answerOptionButtons;
  late int totalQuestions;

  bool hasAnswered = false;
  bool isLoading = true;
  bool isLoadingNextQuestion = false;
  bool isFinished = false;

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

    _loadCurrentQuestion();
    isLoading = false;
  }

  void nextQuestion() {
    if (_currentQuestionIndex >= totalQuestions - 1) {
      isFinished = true;
      notifyListeners();
      return;
    }
    _currentQuestionIndex++;
    _loadCurrentQuestion();
  }

  void _loadCurrentQuestion() {
    hasAnswered = false;

    isLoadingNextQuestion = true;
    final current = _questions[_currentQuestionIndex];
    question = current.text;
    answer = current.answer;
    mode = current.mode;
    answerOptionButtons = mode.strategy.createAnswerOptionButtons(
      onPressed: _handleOptionSelected,
      answerOptionDtos: current.answerOptionDtos,
    );
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 300), () {
      isLoadingNextQuestion = false;
      notifyListeners();
    });
  }

  void _handleOptionSelected(String label) {
    hasAnswered = true;
    answerOptionButtons = mode.strategy.updateAnswerOptionButtons(
      label: label,
      answerOptionButtons: answerOptionButtons,
    );
    notifyListeners();
  }
}
