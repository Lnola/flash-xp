import 'package:flashxp/features/practice/data/answer_option_dto.dart';
import 'package:flashxp/features/practice/logic/practice_mode_strategy.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_list.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_progress.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_question.dart';
import 'package:flashxp/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
    final dummyOptions = [
      AnswerOption(label: 'A', isCorrect: false),
      AnswerOption(label: 'B', isCorrect: false),
      AnswerOption(label: 'C', isCorrect: true),
      AnswerOption(label: 'D', isCorrect: false),
    ];

    _hasAnswered = false;
    options = modeStrategy.createOptions(
      onPressed: _handleOptionSelected,
      answerOptions: dummyOptions,
    );
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
