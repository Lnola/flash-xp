import 'package:flutter/material.dart';

class FlashLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final Color? backgroundColor;

  const FlashLayout({
    super.key,
    required this.title,
    required this.body,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: body,
      ),
    );
  }
}
