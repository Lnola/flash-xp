import 'package:flashxp/pages/create/create_page.dart';
import 'package:flashxp/pages/create/views/create_nested_view.dart';
import 'package:flashxp/pages/explore/explore_page.dart';
import 'package:flashxp/pages/explore/views/explore_nested_view.dart';
import 'package:flashxp/pages/home/home_page.dart';
import 'package:flashxp/pages/home/views/practice_view.dart';
import 'package:flashxp/pages/statistics/statistics_page.dart';
import 'package:flashxp/pages/statistics/views/statistics_nested_view.dart';
import 'package:flashxp/widgets/common/if.dart';
import 'package:flashxp/widgets/layout/flash_layout.dart';
import 'package:flashxp/widgets/layout/flash_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final List<GoRoute> _routes = [
    GoRoute(
      path: '/home',
      pageBuilder: (_, __) => const NoTransitionPage(child: HomePage()),
      routes: [
        GoRoute(
          path: 'nested',
          builder: (_, __) => const FlashLayout(
            title: 'Home Nested Page',
            body: PracticeView(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/explore',
      pageBuilder: (_, __) => const NoTransitionPage(child: ExplorePage()),
      routes: [
        GoRoute(
          path: 'nested',
          builder: (_, __) => const FlashLayout(
            title: 'Explore Nested Page',
            body: ExploreNestedView(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/create',
      pageBuilder: (_, __) => const NoTransitionPage(child: CreatePage()),
      routes: [
        GoRoute(
          path: 'nested',
          builder: (_, __) => const FlashLayout(
            title: 'Create Nested Page',
            body: CreateNestedView(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/statistics',
      pageBuilder: (_, __) => const NoTransitionPage(child: StatisticsPage()),
      routes: [
        GoRoute(
          path: 'nested',
          builder: (_, __) => const FlashLayout(
            title: 'Statistics Nested Page',
            body: StatisticsNestedView(),
          ),
        ),
      ],
    ),
  ];

  static Widget _builder(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    final showNavBar = !_isNestedRoute(state);
    return Scaffold(
      body: child,
      bottomNavigationBar: If(
        condition: showNavBar,
        child: FlashNavBar(
          currentIndex: _getCurrentIndex(state),
          onTap: (index) => _onNavTap(context, index),
        ),
      ),
    );
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: _builder,
        routes: _routes,
      ),
    ],
  );

  static final List<String> rootPaths = _routes
      .map((r) => r.path.startsWith('/') ? r.path : '/${r.path}')
      .toList();

  static int _getCurrentIndex(GoRouterState state) {
    final path = state.fullPath ?? '';
    return rootPaths.indexWhere(path.startsWith);
  }

  static void _onNavTap(BuildContext context, int index) {
    if (index < rootPaths.length) {
      context.go(rootPaths[index]);
    }
  }

  static bool _isNestedRoute(GoRouterState state) {
    final uri = Uri.parse(state.fullPath ?? '');
    return uri.pathSegments.length > 1;
  }
}
