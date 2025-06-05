import 'package:flashxp/pages/home/widgets/practice/practice_option_button.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_option_list.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_progress.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_question.dart';
import 'package:flashxp/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuestionOption {
  final String label;
  final bool isCorrect;

  QuestionOption({
    required this.label,
    this.isCorrect = false,
  });
}

enum PracticeMode { selfAssessment, multipleChoice }

abstract class PracticeModeStrategy {
  List<OptionButtonData> createOptions({
    required void Function(String label) onPressed,
    List<QuestionOption>? options,
  });
  List<OptionButtonData> updateOptions({
    required String label,
    required List<OptionButtonData> options,
  });
}

class SelfAssessmentStrategy implements PracticeModeStrategy {
  @override
  List<OptionButtonData> createOptions({
    required void Function(String label) onPressed,
    List<QuestionOption>? options,
  }) {
    return [
      OptionButtonData(
        label: "I don't know",
        onPressed: () => onPressed("I don't know"),
        state: PracticeOptionState.incorrect,
      ),
      OptionButtonData(
        label: 'I know',
        onPressed: () => onPressed('I know'),
        state: PracticeOptionState.correct,
      ),
    ];
  }

  @override
  List<OptionButtonData> updateOptions({
    required String label,
    required List<OptionButtonData> options,
  }) {
    return options;
  }
}

class MultipleChoiceStrategy implements PracticeModeStrategy {
  static const correctLabel = 'C';

  @override
  List<OptionButtonData> createOptions({
    required void Function(String label) onPressed,
    List<QuestionOption>? options,
  }) {
    if (options == null || options.isEmpty) {
      throw ArgumentError(
        'MultipleChoiceStrategy options cannot be null or empty',
      );
    }
    return _mapOptionsToOptionButtons(
      questionOptions: options,
      onPressed: (label) => onPressed(label),
    );
  }

  @override
  List<OptionButtonData> updateOptions({
    required String label,
    required List<OptionButtonData> options,
  }) {
    return options.map((option) {
      var state = PracticeOptionState.defaultState;
      if (option.isCorrect) {
        state = PracticeOptionState.correct;
      } else if (option.label == label) {
        state = PracticeOptionState.incorrect;
      }
      return option.copyWith(state: state, isDisabled: true);
    }).toList();
  }

  List<OptionButtonData> _mapOptionsToOptionButtons({
    required List<QuestionOption> questionOptions,
    required void Function(String label) onPressed,
  }) {
    return questionOptions.map((questionOption) {
      return OptionButtonData(
        label: questionOption.label,
        isCorrect: questionOption.isCorrect,
        onPressed: () => onPressed(questionOption.label),
      );
    }).toList();
  }
}

class PracticeView extends StatefulWidget {
  const PracticeView({super.key});

  @override
  State<PracticeView> createState() => _PracticeViewState();
}

class _PracticeViewState extends State<PracticeView> {
  bool _hasAnswered = false;
  late PracticeModeStrategy modeStrategy;
  late List<OptionButtonData> options;

  void _handleOptionSelected(label) {
    setState(() {
      _hasAnswered = true;
      options = modeStrategy.updateOptions(label: label, options: options);
    });
  }

  void initQuestion() {
    _hasAnswered = false;
    options = modeStrategy.createOptions(onPressed: _handleOptionSelected);
  }

  @override
  void initState() {
    super.initState();
    modeStrategy = MultipleChoiceStrategy();
    initQuestion();
  }

  @override
  Widget build(BuildContext context) {
    final question =
        'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
    final answer =
        'Answer is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

    void noop() => {};

    void handleNextQuestion() {
      setState(() {
        initQuestion();
      });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 18),
      child: Column(
        children: [
          const PracticeProgress(current: 3, total: 12),
          const SizedBox(height: 16),
          PracticeQuestion(question: question, answer: answer),
          const SizedBox(height: 24),
          PracticeOptionList(options: options),
          const SizedBox(height: 44),
          FlashButton(
            onPressed: _hasAnswered ? handleNextQuestion : noop,
            label: 'Next Question',
            isBlock: true,
          )
              .animate(target: _hasAnswered ? 1 : 0)
              .fade(begin: 0, end: 1, duration: 150.ms)
              .slideY(begin: 1, end: 0, duration: 150.ms),
        ],
      ),
    );
  }
}
