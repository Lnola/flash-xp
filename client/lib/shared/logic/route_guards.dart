import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RouteGuards {
  static Page authGuardedPage({
    required BuildContext context,
    required Widget child,
  }) {
    final auth = Provider.of<AuthService>(context, listen: false);
    if (!auth.isSignedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/auth');
      });
    }

    return NoTransitionPage(child: child);
  }
}
