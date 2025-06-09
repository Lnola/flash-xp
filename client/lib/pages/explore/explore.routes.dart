import 'package:flashxp/pages/explore/explore.page.dart';
import 'package:flashxp/shared/presentation/layout/flash_layout.dart';
import 'package:go_router/go_router.dart';

final exploreRoutes = GoRoute(
  path: '/explore',
  pageBuilder: (_, __) => const NoTransitionPage(
    child: FlashLayout(
      title: 'Explore',
      body: ExplorePage(),
    ),
  ),
);
