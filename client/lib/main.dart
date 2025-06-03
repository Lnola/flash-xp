import 'package:flashxp/pages/home/views/home_view.dart';
import 'package:flashxp/router.dart';
import 'package:flashxp/theme/app_theme.dart';
import 'package:flashxp/widgets/layout/flash_layout.dart';
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

class NestedView extends StatelessWidget {
  const NestedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlashLayout(
      title: 'Nested Page',
      body: HomeView(),
    );
  }
}
