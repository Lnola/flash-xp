import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlashBookmark extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback onPressed;

  const FlashBookmark({
    super.key,
    required this.isBookmarked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final icon =
        isBookmarked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart;

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: FaIcon(
          icon,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          size: 20,
        ),
      ),
    );
  }
}
