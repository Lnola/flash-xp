import 'package:flashxp/pages/statistics/statistics_page.dart';
import 'package:flashxp/pages/statistics/views/statistics_nested_view.dart';
import 'package:flashxp/shared/layout/flash_layout.dart';
import 'package:go_router/go_router.dart';

final statisticsRoutes = GoRoute(
  path: '/statistics',
  pageBuilder: (_, __) => const NoTransitionPage(
    child: FlashLayout(
      title: 'Statistics',
      body: StatisticsPage(),
    ),
  ),
  routes: [
    GoRoute(
      path: 'nested',
      builder: (_, __) => const FlashLayout(
        title: 'Statistics Nested Page',
        body: StatisticsNestedView(),
      ),
    ),
  ],
);
