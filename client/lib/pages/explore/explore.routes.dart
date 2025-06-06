import 'package:flashxp/pages/explore/explore.page.dart';
import 'package:flashxp/pages/explore/views/explore_nested.view.dart';
import 'package:flashxp/shared/layout/flash_layout.dart';
import 'package:go_router/go_router.dart';

final exploreRoutes = GoRoute(
  path: '/explore',
  pageBuilder: (_, __) => const NoTransitionPage(
    child: FlashLayout(
      title: 'Explore',
      body: ExplorePage(),
    ),
  ),
  routes: [
    GoRoute(
      path: 'nested',
      builder: (_, __) => const FlashLayout(
        title: 'Explore Nested Page',
        body: ExploreNestedView(),
      ),
    ),
  ],
);
