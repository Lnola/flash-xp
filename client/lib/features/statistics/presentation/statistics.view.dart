import 'package:flashxp/features/statistics/data/statistics.repository.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/group_bar_chart_card.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/number_card.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/percentage_card.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/pie_chart_card.widget.dart';
import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          GroupBarChartCardWidget(
            days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            series: [
              BarSeries(
                label: 'Correct Answers',
                color: Theme.of(context).colorScheme.tertiary,
                values: [3, 2, 5, 4, 3, 1, 2],
              ),
              BarSeries(
                label: 'Incorrect Answers',
                color: Theme.of(context).colorScheme.error,
                values: [1, 3, 2, 5, 2, 2, 10],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const _NumberCardGroup(
            values: ['100', '50'],
            labels: ['Decks solved today', 'Total decks solved'],
          ),
          const SizedBox(height: 16.0),
          const _NumberCardGroup(
            values: ['5', '10'],
            labels: ['Cards answered today', 'Total cards answered'],
          ),
          const SizedBox(height: 16.0),
          const PercentageCardWidget(
            percent: 0.75,
            label: 'Accuracy rate',
            radius: 56,
            lineWidth: 12,
          ),
          const SizedBox(height: 16.0),
          NumberCardWidget(
            value: controller.dailyStreak.data.toString(),
            isLoading: controller.dailyStreak.isLoading,
            label: 'Streak',
            icon: FontAwesomeIcons.fire,
          ),
          const SizedBox(height: 16.0),
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

class _NumberCardGroup extends StatelessWidget {
  final List<String> values;
  final List<String> labels;

  const _NumberCardGroup({
    required this.values,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        for (int i = 0; i < values.length; i++)
          Expanded(
            child: NumberCardWidget(
              value: values[i],
              label: labels[i],
            ),
          ),
      ],
    );
  }
}
