import 'package:flutter/material.dart';

class FxAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const FxAppBar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(39);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(title),
      ),
    );
  }
}
