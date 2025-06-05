import 'package:flashxp/pages/home/widgets/practice/practice_option_button.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_option_list.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_progress.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_question.dart';
import 'package:flashxp/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum PracticeMode { selfAssessment, multipleChoice }

abstract class PracticeModeStrategy {
  List<OptionButtonData> createOptions(void Function(String label) onPressed);
  void handleOptionPressed({
    required String selectedLabel,
    required List<OptionButtonData> options,
    required void Function(List<OptionButtonData>) updateOptions,
  });
}

class SelfAssessmentStrategy implements PracticeModeStrategy {
  @override
  List<OptionButtonData> createOptions(void Function(String label) onPressed) {
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
  void handleOptionPressed({
    required String selectedLabel,
    required List<OptionButtonData> options,
    required void Function(List<OptionButtonData>) updateOptions,
  }) {}
}

class MultipleChoiceStrategy implements PracticeModeStrategy {
  static const correctLabel = 'C';

  @override
  List<OptionButtonData> createOptions(void Function(String label) onPressed) {
    final labels = ['A', 'B', 'C', 'D'];
    return labels.map((label) {
      final isCorrect = label == correctLabel;
      return OptionButtonData(
        label: label,
        isCorrect: isCorrect,
        onPressed: () => onPressed(label),
      );
    }).toList();
  }

  @override
  void handleOptionPressed({
    required String selectedLabel,
    required List<OptionButtonData> options,
    required void Function(List<OptionButtonData>) updateOptions,
  }) {
    final updated = options.map((option) {
      var state = PracticeOptionState.defaultState;
      if (option.isCorrect) {
        state = PracticeOptionState.correct;
      } else if (option.label == selectedLabel) {
        state = PracticeOptionState.incorrect;
      }
      return option.copyWith(state: state, isDisabled: true);
    }).toList();

    updateOptions(updated);
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

  void initQuestion() {
    _hasAnswered = false;
    options = modeStrategy.createOptions((label) {
      setState(() {
        _hasAnswered = true;
        modeStrategy.handleOptionPressed(
          selectedLabel: label,
          options: options,
          updateOptions: (updated) => options = updated,
        );
      });
    });
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
