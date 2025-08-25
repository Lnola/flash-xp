import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/number_card.widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DailyStreakWidget extends StatelessWidget {
  final StatStore<int> dailyStreak;

  const DailyStreakWidget({super.key, required this.dailyStreak});

  @override
  Widget build(BuildContext context) {
    return NumberCardWidget(
      value: dailyStreak.data.toString(),
      isLoading: dailyStreak.isLoading,
      label: 'Streak',
      icon: FontAwesomeIcons.fire,
    );
  }
}
