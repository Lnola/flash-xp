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
