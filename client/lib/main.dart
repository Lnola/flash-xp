import 'package:flashxp/shared/router.dart';
import 'package:flashxp/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'flash-xp',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
