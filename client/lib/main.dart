import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flashxp/theme/app_theme.dart';
import 'package:flashxp/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "flash-xp",
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
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
