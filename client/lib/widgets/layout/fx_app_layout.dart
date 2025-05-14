import 'package:flashxp/main.dart';
import 'package:flutter/material.dart';
import 'package:flashxp/widgets/common/if.dart';
import 'package:flashxp/widgets/layout/fx_app_bar.dart';
import 'package:flashxp/widgets/layout/fx_app_navigation.dart';
import 'package:provider/provider.dart';

class FxAppLayout extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final bool showNavigation;
  final int currentIndex;
  final ValueChanged<int>? onNavigationTap;

  const FxAppLayout({
    super.key,
    required this.child,
    this.showBackButton = false,
    this.showNavigation = false,
    this.currentIndex = 0,
    this.onNavigationTap,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NavigationState>();
    var title = appState.title;

    return Scaffold(
      appBar: FxAppBar(
        title: title,
        showBackButton: showBackButton,
      ),
      body: child,
      bottomNavigationBar: If(
        condition: showNavigation && onNavigationTap != null,
        builder: (_) => FxAppNavigation(
          currentIndex: currentIndex,
          onTap: onNavigationTap!,
        ),
      ),
    );
  }
}
