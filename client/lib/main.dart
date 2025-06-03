import 'package:flashxp/router.dart';
import 'package:flashxp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'flash-xp',
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
    return const Layout(
      title: 'Nested Page',
      body: RootView(),
    );
  }
}
