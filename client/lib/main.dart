import 'package:flutter/material.dart';
import 'package:flashxp/theme/app_theme.dart';
import 'package:flashxp/widgets/layout/fx_app_layout.dart';

import 'package:flashxp/pages/home/home_view.dart';
import 'package:flashxp/pages/explore/explore_view.dart';
import 'package:flashxp/pages/create/create_view.dart';
import 'package:flashxp/pages/statistics/statistics_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flash-xp",
      theme: AppTheme.light,
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeView(),
    ExploreView(),
    CreateView(),
    StatisticsView(),
  ];

  final List<String> _titles = [
    "Home",
    "Explore",
    "Create",
    "Statistics",
  ];

  @override
  Widget build(BuildContext context) {
    return FxAppLayout(
      title: _titles[_currentIndex],
      showBackButton: false,
      showNavigation: true,
      currentIndex: _currentIndex,
      onNavigationTap: (i) => setState(() => _currentIndex = i),
      child: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
