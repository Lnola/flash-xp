import 'package:flashxp/pages/create/create_page.dart';
import 'package:flashxp/pages/create/views/create_nested_view.dart';
import 'package:flashxp/shared/layout/flash_layout.dart';
import 'package:go_router/go_router.dart';

final createRoutes = GoRoute(
  path: '/create',
  pageBuilder: (_, __) => const NoTransitionPage(
    child: FlashLayout(
      title: 'Create',
      body: CreatePage(),
    ),
  ),
  routes: [
    GoRoute(
      path: 'nested',
      builder: (_, __) => const FlashLayout(
        title: 'Create Nested Page',
        body: CreateNestedView(),
      ),
    ),
  ],
);
