import 'package:flashxp/features/practice/data/quick_practice.repository.dart';
import 'package:flashxp/features/practice/logic/practice.controller.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_answer_options.widget.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_progress.widget.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_question.widget.dart';
import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flashxp/shared/presentation/widgets/flash_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

// TODO: add a way to denote if the mode is either QuickPractice or SmartPractice
class PracticeView extends StatefulWidget {
  final int deckId;

  const PracticeView({super.key, required this.deckId});

  @override
  State<PracticeView> createState() => _PracticeViewState();
}

class _PracticeViewState extends State<PracticeView> {
  late final PracticeController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = PracticeController(widget.deckId, QuickPracticeRepository());
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.error != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        useSnackbar(context, controller.error, 'Failed to load questions.');
        context.pop();
      });
      return const SizedBox.shrink();
    }

    if (controller.isLoading) {
      return const Center(child: FlashLoading());
    }

    if (controller.isFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home/practice/finished');
      });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 18),
      child: Column(
        children: [
          PracticeProgress(
            current: controller.currentQuestionIndex,
            total: controller.totalQuestions,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PracticeQuestion(
              question: controller.question,
              answer: controller.answer,
            ),
          )
              .animate(target: !controller.isLoadingNextQuestion ? 1 : 0)
              .slideX(begin: 1.2, end: 0, duration: 150.ms),
          const SizedBox(height: 24),
          PracticeAnswerOptions(
            answerOptionButtons: controller.answerOptionButtons,
          )
              .animate(target: !controller.isLoadingNextQuestion ? 1 : 0)
              .slideX(begin: 1.2, end: 0, duration: 150.ms),
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
