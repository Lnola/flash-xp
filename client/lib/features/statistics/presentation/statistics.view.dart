import 'package:flashxp/features/statistics/data/statistics.repository.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/accuracy_rate.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/answer_count_group.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/pie_chart_card.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/daily_correct_incorrect.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/daily_streak.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/deck_count_group.widget.dart';
import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
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
          DailyCorrectIncorrectWidget(
            dailyCorrectIncorrect: controller.dailyCorrectIncorrect,
          ),
          const SizedBox(height: 16.0),
          DeckCountGroupWidget(
            deckCountToday: controller.deckCountToday,
            deckCountTotal: controller.deckCountTotal,
          ),
          const SizedBox(height: 16.0),
          AnswerCountGroupWidget(
            answerCountToday: controller.answerCountToday,
            answerCountTotal: controller.answerCountTotal,
          ),
          const SizedBox(height: 16.0),
          AccuracyRateWidget(accuracyRate: controller.accuracyRate),
          const SizedBox(height: 16.0),
          DailyStreakWidget(dailyStreak: controller.dailyStreak),
          const SizedBox(height: 16.0),
          // TODO: implement this
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
