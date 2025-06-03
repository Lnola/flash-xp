import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flashxp/main.dart';

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
