import 'package:flashxp/features/practice/logic/practice.controller.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_answer_options.widget.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_progress.widget.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_question.widget.dart';
import 'package:flashxp/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PracticeView extends StatefulWidget {
  const PracticeView({super.key});

  @override
  State<PracticeView> createState() => _PracticeViewState();
}

class _PracticeViewState extends State<PracticeView> {
  late final PracticeController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = PracticeController();
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 18),
      child: Column(
        children: [
          const PracticeProgress(current: 3, total: 12),
          const SizedBox(height: 16),
          PracticeQuestion(
            question: controller.question,
            answer: controller.answer,
          ),
          const SizedBox(height: 24),
          PracticeAnswerOptions(
            answerOptionButtons: controller.answerOptionButtons,
          ),
          const SizedBox(height: 44),
          FlashButton(
            onPressed: controller.hasAnswered ? controller.nextQuestion : () {},
            label: 'Next Question',
            isBlock: true,
          )
              .animate(target: controller.hasAnswered ? 1 : 0)
              .fade(begin: 0, end: 1, duration: 150.ms)
              .slideY(begin: 1, end: 0, duration: 150.ms),
        ],
      ),
    );
  }
}
