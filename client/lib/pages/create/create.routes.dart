import 'package:flashxp/pages/create/create.page.dart';
import 'package:flashxp/shared/presentation/layout/flash_layout.dart';
import 'package:go_router/go_router.dart';

final createRoutes = GoRoute(
  path: '/create',
  pageBuilder: (_, __) => const NoTransitionPage(
    child: FlashLayout(
      title: 'Create',
      body: CreatePage(),
    ),
  ),
);
