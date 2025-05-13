import 'package:flutter/material.dart';
import 'package:flashxp/widgets/layout/app_layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flash-xp",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
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
    return AppLayout(
      title: _titles[_currentIndex],
      bottomNavBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Decks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
      child: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
