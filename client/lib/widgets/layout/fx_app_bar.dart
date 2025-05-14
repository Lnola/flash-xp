import 'package:flashxp/widgets/common/if.dart';
import 'package:flutter/material.dart';

class FxAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const FxAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(39);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: If(
        condition: showBackButton,
        builder: (_) => IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(title),
      ),
    );
  }
}
