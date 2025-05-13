import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomNavBar;

  const AppLayout({
    required this.title,
    required this.child,
    this.bottomNavBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: child,
      bottomNavigationBar: bottomNavBar, // ← MAKE SURE THIS IS HERE
    );
  }
}
