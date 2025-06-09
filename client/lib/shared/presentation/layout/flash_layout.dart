import 'package:flashxp/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlashLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final Color? backgroundColor;
  final Color? appBarColor;
  final GoRouterState? state;

  const FlashLayout({
    super.key,
    required this.title,
    required this.body,
    this.backgroundColor,
    this.appBarColor,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(state?.metadata?.title ?? title),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: body,
      ),
    );
  }
}
