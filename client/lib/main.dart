import 'package:flutter/material.dart';
import 'package:flashxp/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

void _onNavTap(BuildContext context, int index) {
  final paths = ['/home', '/explore', '/create', '/stats'];
  context.go(paths[index]);
}

int _indexFromLocation(String location) {
  if (location.startsWith('/home')) return 0;
  if (location.startsWith('/explore')) return 1;
  if (location.startsWith('/create')) return 2;
  if (location.startsWith('/stats')) return 3;
  return 0;
}

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final showNav = !state.fullPath!.contains('/nested');
        return Scaffold(
          body: child,
          bottomNavigationBar: showNav
              ? BottomNavBar(
                  currentIndex: _indexFromLocation(state.fullPath ?? ''),
                  onTap: (index) => _onNavTap(context, index),
                )
              : null,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (_, __) => const NoTransitionPage(child: HomePage()),
          routes: [
            GoRoute(
              path: 'nested',
              builder: (_, __) => const NestedView(),
            ),
          ],
        ),
        GoRoute(
          path: '/explore',
          pageBuilder: (_, __) => const NoTransitionPage(child: ExplorePage()),
          routes: [
            GoRoute(
              path: 'nested',
              builder: (_, __) => const NestedView(),
            ),
          ],
        ),
        GoRoute(
          path: '/create',
          pageBuilder: (_, __) => const NoTransitionPage(child: CreatePage()),
          routes: [
            GoRoute(
              path: 'nested',
              builder: (_, __) => const NestedView(),
            ),
          ],
        ),
        GoRoute(
          path: '/stats',
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: StatisticsPage()),
          routes: [
            GoRoute(
              path: 'nested',
              builder: (_, __) => const NestedView(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "flash-xp",
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
      ],
    );
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
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
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
    final currentPath = GoRouterState.of(context).uri.toString();

    return Center(
      child: ElevatedButton(
        child: const Text('Push new page'),
        onPressed: () {
          context.push('$currentPath/nested');
        },
      ),
    );
  }
}

class NestedView extends StatelessWidget {
  const NestedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Nested Page',
      body: RootView(),
    );
  }
}
