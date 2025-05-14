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
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(),
    CreatePage(),
    StatisticsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FxAppLayout(
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

class NavigationState extends ChangeNotifier {
  var title = "Home";

  void setTitle(String title) {
    title = title;
    notifyListeners();
  }
}
