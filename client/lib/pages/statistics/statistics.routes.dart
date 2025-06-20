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
);
