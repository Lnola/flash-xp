import 'package:flashxp/pages/create/create.routes.dart';
import 'package:flashxp/pages/explore/explore.routes.dart';
import 'package:flashxp/pages/home/home.routes.dart';
import 'package:flashxp/pages/statistics/statistics.routes.dart';
import 'package:flashxp/shared/layout/flash_nav_bar.dart';
import 'package:flashxp/shared/layout/flash_not_found.dart';
import 'package:flashxp/shared/widgets/utils/if.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final List<GoRoute> _routes = [
    homeRoutes,
    exploreRoutes,
    createRoutes,
    statisticsRoutes,
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
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: FlashNotFound(),
    ),
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
