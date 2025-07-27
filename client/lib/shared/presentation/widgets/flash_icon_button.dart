import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlashIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const FlashIconButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: label,
      onPressed: onPressed,
      label: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
      ),
      icon: FaIcon(
        icon,
        size: 16,
      ),
      elevation: 0,
    );
  }
}
