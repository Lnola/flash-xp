import 'package:flashxp/features/statistics/presentation/statistics_nested.view.dart';
import 'package:flashxp/pages/statistics/statistics.page.dart';
import 'package:flashxp/shared/logic/route_guards.dart';
import 'package:flashxp/shared/presentation/layout/flash_layout.dart';
import 'package:go_router/go_router.dart';

final statisticsRoutes = GoRoute(
  path: '/statistics',
  pageBuilder: (context, __) => RouteGuards.authGuard(
    context,
    child: const NoTransitionPage(
      child: FlashLayout(
        title: 'Statistics',
        body: StatisticsPage(),
      ),
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
