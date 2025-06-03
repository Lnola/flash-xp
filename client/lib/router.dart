import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flashxp/main.dart';
import 'package:flashxp/widgets/layout/flash_nav_bar.dart';
import 'package:flashxp/widgets/common/if.dart';

class RouteMeta {
  final bool showNavBar;
  const RouteMeta({this.showNavBar = true});
}

class MetaRoute extends GoRoute {
  final RouteMeta? metadata;

  MetaRoute({
    required super.path,
    super.name,
    super.parentNavigatorKey,
    super.redirect,
    super.pageBuilder,
    super.builder,
    super.routes = const <RouteBase>[],
    this.metadata,
  });
}

class AppRouter {
  static final List<MetaRoute> _routes = [
    MetaRoute(
      path: '/home',
      pageBuilder: (_, __) => const NoTransitionPage(child: HomePage()),
      routes: [
        MetaRoute(
          path: 'nested',
          builder: (_, __) => const NestedView(),
        ),
      ],
    ),
    MetaRoute(
      path: '/explore',
      pageBuilder: (_, __) => const NoTransitionPage(child: ExplorePage()),
      routes: [
        MetaRoute(
          path: 'nested',
          metadata: const RouteMeta(showNavBar: false),
          builder: (_, __) => const NestedView(),
        ),
      ],
    ),
    MetaRoute(
      path: '/create',
      pageBuilder: (_, __) => const NoTransitionPage(child: CreatePage()),
      routes: [
        MetaRoute(
          path: 'nested',
          metadata: const RouteMeta(showNavBar: false),
          builder: (_, __) => const NestedView(),
        ),
      ],
    ),
    MetaRoute(
      path: '/statistics',
      pageBuilder: (_, __) => const NoTransitionPage(child: StatisticsPage()),
      routes: [
        MetaRoute(
          path: 'nested',
          metadata: const RouteMeta(showNavBar: false),
          builder: (_, __) => const NestedView(),
        ),
      ],
    ),
  ];

  static Widget _builder(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    final showNav = !state.fullPath!.contains('/nested');
    return Scaffold(
      body: child,
      bottomNavigationBar: If(
        condition: showNav,
        child: FlashNavBar(
          currentIndex: indexFromLocation(state),
          onTap: (index) => onNavTap(context, index),
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
