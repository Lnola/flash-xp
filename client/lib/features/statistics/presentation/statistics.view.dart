import 'package:flashxp/features/statistics/presentation/widgets/group_bar_chart_card.widget.dart';
import 'package:flashxp/features/statistics/presentation/widgets/number_card.widget.dart';
import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  void _signOut(BuildContext context) async {
    final authService = context.read<AuthService>();
    await authService.signOut();
    if (!context.mounted) return;
    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GroupBarChartCardWidget(
            days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            first: [3, 2, 5, 4, 3, 1, 2],
            second: [1, 3, 2, 5, 2, 2, 10],
            firstLabel: 'Correct Answers',
            secondLabel: 'Incorrect Answers',
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
