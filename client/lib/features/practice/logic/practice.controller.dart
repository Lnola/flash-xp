import 'package:flashxp/features/practice/data/dto/question.dto.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode_multiple_choice.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode_self_assessment.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_type.enum.dart';
import 'package:flashxp/features/practice/logic/domain/practice_type.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_type_quick_practice.strategy.dart';
import 'package:flashxp/features/practice/logic/domain/practice_type_smart_review.strategy.dart';
import 'package:flashxp/features/practice/logic/models/answer_option_button.model.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

extension on PracticeMode {
  PracticeModeStrategy get strategy => switch (this) {
        PracticeMode.multipleChoice => MultipleChoiceStrategy(),
        PracticeMode.selfAssessment => SelfAssessmentStrategy(),
      };
}

extension on PracticeType {
  PracticeTypeStrategy get strategy => switch (this) {
        PracticeType.quickPractice => QuickPracticeStrategy(),
        PracticeType.smartReview => SmartReviewStrategy(),
      };
}

class PracticeController extends ChangeNotifier {
  final int deckId;
  final PracticeType practiceType;
  late PracticeMode mode;

  late String question;
  late String? answer;
  late List<AnswerOptionButtonModel> answerOptionButtons;
  late int totalQuestions;

  bool hasAnswered = false;
  bool isLoading = true;
  bool isLoadingNextQuestion = false;
  bool isFinished = false;
  String? criticalError;
  String? answerError;

  final List<QuestionDto> _questions = [];
  int _currentQuestionIndex = 0;

  int get currentQuestionIndex => _currentQuestionIndex + 1;

  PracticeController(this.deckId, this.practiceType) {
    _initQuestions();
  }

  Future<void> _initQuestions() async {
    isLoading = true;
    notifyListeners();

    final result = await practiceType.strategy.getQuestions(deckId);
    if (result.error != null) {
      criticalError = result.error;
      isLoading = false;
      notifyListeners();
      return;
    }
    _questions.addAll(result.data!);

    totalQuestions = _questions.length;
    _currentQuestionIndex = 0;

    _loadCurrentQuestion();
    isLoading = false;
    notifyListeners();
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

  void _handleOptionSelected(String label) async {
    answerError = null;
    final isCorrectAnswerSelected = mode.strategy.isAnswerCorrect(
      buttonLabel: label,
      answerOptionButtons: answerOptionButtons,
    );
    if (isCorrectAnswerSelected) {
      final questionId = _questions[_currentQuestionIndex].id;
      final result = await practiceType.strategy.handleCorrectAnswer(
        questionId,
      );
      if (result.error != null) {
        answerError =
            'Failed to submit answer, please try again. If the problem persists, restart the app.';
        notifyListeners();
        return;
      }
    }
    hasAnswered = true;
    answerOptionButtons = mode.strategy.updateAnswerOptionButtons(
      label: label,
      answerOptionButtons: answerOptionButtons,
    );
    notifyListeners();
  }
}
