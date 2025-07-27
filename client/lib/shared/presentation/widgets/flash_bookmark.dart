import 'package:flashxp/shared/presentation/widgets/flash_button_icon.dart';
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
    return FlashButtonIcon(icon: icon, onPressed: onPressed);
  }
}
