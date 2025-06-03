import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flashxp/main.dart';
import 'package:flashxp/widgets/layout/flash_nav_bar.dart';

class AppRouter {
  static final List<GoRoute> _routes = [
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
      path: '/statistics',
      pageBuilder: (_, __) => const NoTransitionPage(child: StatisticsPage()),
      routes: [
        GoRoute(
          path: 'nested',
          builder: (_, __) => const NestedView(),
        ),
      ],
    ),
  ];

  static Widget _shellRouteBuilder(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    final showNav = !state.fullPath!.contains('/nested');
    return Scaffold(
      body: child,
      bottomNavigationBar: showNav
          ? FlashNavBar(
              currentIndex: indexFromLocation(state),
              onTap: (index) => onNavTap(context, index),
            )
          : null,
    );
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: _shellRouteBuilder,
        routes: _routes,
      ),
    ],
  );

  static final List<String> rootPaths = _routes
      .map((r) => r.path.startsWith('/') ? r.path : '/${r.path}')
      .toList();

  static void onNavTap(BuildContext context, int index) {
    if (index < rootPaths.length) {
      context.go(rootPaths[index]);
    }
  }

  static int indexFromLocation(GoRouterState state) {
    final path = state.fullPath ?? '';
    return rootPaths.indexWhere(path.startsWith);
  }
}
