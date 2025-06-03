import 'package:flashxp/main.dart';
import 'package:flashxp/pages/statistics/views/statistics_view.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      title: 'Statistics',
      body: StatisticsView(),
    );
  }
}
