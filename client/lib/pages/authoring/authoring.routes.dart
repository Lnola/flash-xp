import 'package:flashxp/features/authoring/presentation/edit.view.dart';
import 'package:flashxp/pages/authoring/authoring.page.dart';
import 'package:flashxp/shared/logic/route_guards.dart';
import 'package:flashxp/shared/presentation/layout/flash_layout.dart';
import 'package:go_router/go_router.dart';

final authoringRoutes = GoRoute(
  path: '/authoring',
  pageBuilder: (context, __) => RouteGuards.authGuard(
    context,
    child: const NoTransitionPage(
      child: FlashLayout(
        title: 'Create',
        body: AuthoringPage(),
      ),
    ),
  ),
  routes: [
    GoRoute(
      path: ':deckId/edit',
      pageBuilder: (context, state) {
        final deckId = int.tryParse(state.pathParameters['deckId'] ?? '');
        if (deckId == null) return RouteGuards.showError(context);
        return RouteGuards.authGuard(
          context,
          child: NoTransitionPage(
            child: FlashLayout(
              title: 'Edit',
              body: EditView(deckId: deckId),
            ),
          ),
        );
      },
    ),
  ],
);
