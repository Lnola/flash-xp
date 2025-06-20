import 'package:flashxp/pages/auth/auth.page.dart';
import 'package:flashxp/shared/presentation/layout/flash_layout.dart';
import 'package:go_router/go_router.dart';

final authRoutes = GoRoute(
  path: '/auth',
  pageBuilder: (_, __) => const NoTransitionPage(
    child: FlashLayout(
      title: 'Auth',
      body: AuthPage(),
    ),
  ),
);
