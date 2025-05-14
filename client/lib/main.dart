import 'package:flashxp/state/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flashxp/theme/app_theme.dart';
import 'package:flashxp/widgets/layout/fx_app_layout.dart';

import 'package:flashxp/pages/home/home_page.dart';
import 'package:flashxp/pages/explore/explore_page.dart';
import 'package:flashxp/pages/create/create_page.dart';
import 'package:flashxp/pages/statistics/statistics_page.dart';
import 'package:provider/provider.dart';

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
      home: ChangeNotifierProvider(
        create: (_) => NavigationState(),
        child: const MainScaffold(),
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(),
    CreatePage(),
    StatisticsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationState = context.watch<NavigationState>();
    final tabIndex = navigationState.tabIndex;

    return FxAppLayout(
      showBackButton: false,
      showNavigation: true,
      child: IndexedStack(
        index: tabIndex,
        children: _pages,
      ),
    );
  }
}
