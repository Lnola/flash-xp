import 'package:flashxp/pages/create/create.page.dart';
import 'package:flashxp/shared/logic/route_guards.dart';
import 'package:flashxp/shared/presentation/layout/flash_layout.dart';
import 'package:go_router/go_router.dart';

final createRoutes = GoRoute(
  path: '/create',
  pageBuilder: (context, __) => RouteGuards.authGuard(
    context,
    child: const NoTransitionPage(
      child: FlashLayout(
        title: 'Create',
        body: CreatePage(),
      ),
    ),
  ),
);
