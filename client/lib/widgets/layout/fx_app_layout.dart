import 'package:flashxp/widgets/layout/fx_app_bar.dart';
import 'package:flashxp/widgets/layout/fx_app_navigation.dart';
import 'package:flutter/material.dart';

class FxAppLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showBackButton;
  final bool showNavigation;
  final int currentIndex;
  final ValueChanged<int>? onNavigationTap;

  const FxAppLayout({
    super.key,
    required this.title,
    required this.child,
    this.showBackButton = false,
    this.showNavigation = false,
    this.currentIndex = 0,
    this.onNavigationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FxAppBar(
        title: title,
        showBackButton: showBackButton,
      ),
      body: child,
      bottomNavigationBar: showNavigation && onNavigationTap != null
          ? FxAppNavigation(
              currentIndex: currentIndex,
              onTap: onNavigationTap!,
            )
          : null,
    );
  }
}
