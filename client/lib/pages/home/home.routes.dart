import 'package:flashxp/features/practice/presentation/practice.view.dart';
import 'package:flashxp/features/practice/presentation/practice_finished.view.dart';
import 'package:flashxp/features/preview/presentation/preview.view.dart';
import 'package:flashxp/pages/home/home.page.dart';
import 'package:flashxp/shared/logic/route_guards.dart';
import 'package:flashxp/shared/presentation/layout/flash_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final homeRoutes = GoRoute(
  path: '/home',
  pageBuilder: (context, __) => RouteGuards.authGuard(
    context,
    child: const NoTransitionPage(
      child: FlashLayout(
        title: 'Home',
        body: HomePage(),
      ),
    ),
  ),
  routes: [
    GoRoute(
      path: ':deckId/practice',
      builder: (context, state) {
        final deckId = int.tryParse(state.pathParameters['deckId'] ?? '');
        if (deckId == null) return RouteGuards.showError(context);
        return FlashLayout(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: 'Practice',
          body: PracticeView(deckId: deckId),
        );
      },
    ),
    GoRoute(
      path: 'practice/finished',
      builder: (context, __) => FlashLayout(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBarColor: Theme.of(context).colorScheme.secondary,
        title: 'Practice finished',
        body: const PracticeFinishedView(),
      ),
    ),
    GoRoute(
      path: ':deckId/preview',
      builder: (context, state) {
        final deckId = int.tryParse(state.pathParameters['deckId'] ?? '');
        if (deckId == null) return RouteGuards.showError(context);
        return FlashLayout(
          state: state,
          title: 'Preview deck',
          body: PreviewView(deckId: deckId),
        );
      },
    ),
  ],
);
