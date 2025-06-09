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

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: const StadiumBorder(),
      ),
      child: FaIcon(
        icon,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
