import 'package:flashxp/pages/home/widgets/practice/practice_option_button.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_option_list.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_progress.dart';
import 'package:flashxp/pages/home/widgets/practice/practice_question.dart';
import 'package:flashxp/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum PracticeMode { selfAssessment, multipleChoice }

// TODO: clean up this factory and clicking logic
class OptionButtonFactory {
  static List<OptionButtonData> create({
    required PracticeMode mode,
    required void Function(String label) onPressed,
  }) {
    if (mode == PracticeMode.selfAssessment) {
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

    final labels = ['A', 'B', 'C', 'D'];
    const correctLabel = 'C';

    return labels.map((label) {
      final isCorrect = label == correctLabel;
      return OptionButtonData(
        label: label,
        isCorrect: isCorrect,
        onPressed: () => onPressed(label),
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
  PracticeMode mode = PracticeMode.multipleChoice;
  late List<OptionButtonData> options;

  void handleOptionPressed(String label) {
    setState(() {
      options = options.map((option) {
        var state = PracticeOptionState.defaultState;
        if (option.isCorrect) {
          state = PracticeOptionState.correct;
        } else if (option.label == label) {
          state = PracticeOptionState.incorrect;
        }
        return option.copyWith(state: state, isDisabled: true);
      }).toList();
    });
  }

  void initQuestion() {
    _hasAnswered = false;
    options = OptionButtonFactory.create(
      mode: mode,
      onPressed: (label) {
        _hasAnswered = true;
        if (mode == PracticeMode.multipleChoice) handleOptionPressed(label);
      },
    );
  }

  @override
  void initState() {
    super.initState();
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
