import 'package:flashxp/widgets/layout/fx_app_bar.dart';
import 'package:flutter/material.dart';

class FxAppLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomNavBar;

  const FxAppLayout({
    required this.title,
    required this.child,
    this.bottomNavBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FxAppBar(title: title),
      body: child,
      bottomNavigationBar: bottomNavBar,
    );
  }
}
