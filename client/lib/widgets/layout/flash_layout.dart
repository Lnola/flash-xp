import 'package:flutter/material.dart';

class FlashLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final Color? backgroundColor;
  final Color? appBarColor;

  const FlashLayout({
    super.key,
    required this.title,
    required this.body,
    this.backgroundColor,
    this.appBarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: body,
      ),
    );
  }
}
