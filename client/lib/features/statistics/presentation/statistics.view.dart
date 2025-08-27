import 'package:flashxp/features/statistics/data/statistics.repository.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/accuracy_rate.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/answer_count_group.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/pie_chart_card.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/common_incorrectly_answered_questions.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/daily_correct_incorrect.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/daily_streak.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/deck_count_group.widget.dart';
import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flashxp/shared/presentation/widgets/utils/if.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => StatisticsViewState();
}

class StatisticsViewState extends State<StatisticsView> {
  late final StatisticsController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = StatisticsController(StatisticsRepository());
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    controller.dispose();
    super.dispose();
  }

  void _signOut(BuildContext context) async {
    final authService = context.read<AuthService>();
    await authService.signOut();
    if (!context.mounted) return;
    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GeneralStatisticsSection(controller: controller),
          const SizedBox(height: 32),
          _PerformanceAnalysisSection(controller: controller),
          const SizedBox(height: 32),
          _TipsSection(controller: controller),
          const SizedBox(height: 16.0),
          FlashButton(
            onPressed: () => _signOut(context),
            label: 'Sign Out',
            isBlock: true,
          ),
        ],
      ),
    );
  }
}

class _GeneralStatisticsSection extends StatelessWidget {
  const _GeneralStatisticsSection({required this.controller});

  final StatisticsController controller;

  @override
  Widget build(BuildContext context) {
    return _Section(
      children: [
        DailyCorrectIncorrectWidget(
          dailyCorrectIncorrect: controller.dailyCorrectIncorrect,
        ),
        const SizedBox(height: 16.0),
        DailyStreakWidget(dailyStreak: controller.dailyStreak),
        const SizedBox(height: 16.0),
        AnswerCountGroupWidget(
          answerCountToday: controller.answerCountToday,
          answerCountTotal: controller.answerCountTotal,
        ),
        const SizedBox(height: 16.0),
        DeckCountGroupWidget(
          deckCountToday: controller.deckCountToday,
          deckCountTotal: controller.deckCountTotal,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class _PerformanceAnalysisSection extends StatelessWidget {
  final StatisticsController controller;

  const _PerformanceAnalysisSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Performance analysis',
      children: [
        AccuracyRateWidget(accuracyRate: controller.accuracyRate),
        const SizedBox(height: 16),
        PieChartCardWidget(
          slices: [
            PieSlice(
              label: 'Self Assessment',
              value: 30,
              color: Theme.of(context).colorScheme.secondary,
            ),
            PieSlice(
              label: 'Multiple Choice',
              value: 70,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ),
      ],
    );
  }
}

class _TipsSection extends StatelessWidget {
  final StatisticsController controller;

  const _TipsSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Tips to improve',
      children: [
        CommonIncorrectlyAnsweredQuestionsWidget(
          incorrectlyAnsweredQuestions:
              controller.commonIncorrectlyAnsweredQuestions,
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _Section({
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        If(
          condition: title != null,
          builder: (context) =>
              Text(title!, style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}
