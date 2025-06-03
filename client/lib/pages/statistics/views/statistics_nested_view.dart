import 'package:flashxp/pages/statistics/views/statistics_view.dart';
import 'package:flashxp/widgets/layout/flash_layout.dart';
import 'package:flutter/material.dart';

class StatisticsNestedView extends StatelessWidget {
  const StatisticsNestedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlashLayout(
      title: 'Statistics Nested Page',
      body: StatisticsView(),
    );
  }
}
