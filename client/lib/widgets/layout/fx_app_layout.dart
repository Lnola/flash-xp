import 'package:flashxp/state/navigation_state.dart';
import 'package:flashxp/widgets/common/if.dart';
import 'package:flashxp/widgets/layout/fx_app_bar.dart';
import 'package:flashxp/widgets/layout/fx_app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FxAppLayout extends StatelessWidget {
  final Widget child;
  final bool showNavigation;

  const FxAppLayout({
    super.key,
    required this.child,
    this.showNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    final navigationState = context.watch<NavigationState>();
    final title = navigationState.title;
    final showBackButton = navigationState.showBackButton;
    final tabIndex = navigationState.tabIndex;
    final setTabIndex = navigationState.setTabIndex;

    return Scaffold(
      appBar: FxAppBar(
        title: title,
        showBackButton: showBackButton,
      ),
      body: child,
      bottomNavigationBar: If(
        condition: showNavigation,
        builder: (_) => FxAppNavigation(
          currentIndex: tabIndex,
          onTap: setTabIndex,
        ),
      ),
    );
  }
}
