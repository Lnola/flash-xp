import 'package:flutter/material.dart';
import 'package:flashxp/theme/app_theme.dart';
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
        child: MainScaffold(),
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
  final List<Widget> _tabs = const [
    HomePage(),
    ExplorePage(),
    CreatePage(),
    StatisticsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationState = context.watch<NavigationState>();
    final currentIndex = navigationState.currentIndex;
    final navKeys = navigationState.navKeys;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: List.generate(
          _tabs.length,
          (i) => Navigator(
            key: navKeys[i],
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => _tabs[i],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationState extends ChangeNotifier {
  int currentIndex = 0;

  final List<GlobalKey<NavigatorState>> navKeys = List.generate(
    4,
    (_) => GlobalKey<NavigatorState>(),
  );

  void setCurrentIndex(int index) {
    if (index == currentIndex) {
      navKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      currentIndex = index;
    }
    notifyListeners();
  }
}

class Layout extends StatelessWidget {
  final String title;
  final Widget body;

  const Layout({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final navigationState = context.watch<NavigationState>();
    final currentIndex = navigationState.currentIndex;
    final setCurrentIndex = navigationState.setCurrentIndex;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: setCurrentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Home",
      body: RootView(),
    );
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Explore',
      body: RootView(),
    );
  }
}

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Create',
      body: RootView(),
    );
  }
}

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Statistics',
      body: RootView(),
    );
  }
}

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Push new page'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NestedView(),
            ),
          );
        },
      ),
    );
  }
}

class NestedView extends StatelessWidget {
  const NestedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nested Page')),
      body: const Center(child: Text('You pushed a new page!')),
    );
  }
}
