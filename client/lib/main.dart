import 'package:flutter/material.dart';
import 'package:flashxp/theme/app_theme.dart';
import 'package:flashxp/widgets/layout/fx_app_layout.dart';

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

  final List<Widget> _pages = [
    const Center(child: Text("Home Page")),
    const Center(child: Text("Decks Page")),
    const Center(child: Text("Profile Page")),
    const Center(child: Text("Settings Page")),
  ];

  final List<String> _titles = [
    "Home",
    "Decks",
    "Profile",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return FxAppLayout(
      title: _titles[_currentIndex],
      showBackButton: true,
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
