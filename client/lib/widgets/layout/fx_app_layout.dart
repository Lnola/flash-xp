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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(39),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(title),
          ),
        ),
      ),
      body: child,
      bottomNavigationBar: bottomNavBar,
    );
  }
}
