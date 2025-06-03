import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlashNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const FlashNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.onSurface,
      unselectedItemColor:
          Theme.of(context).colorScheme.onSurface.withAlpha(77),
      selectedLabelStyle: Theme.of(context).textTheme.displaySmall,
      unselectedLabelStyle: Theme.of(context).textTheme.displaySmall,
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidCompass),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.circlePlus),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.chartColumn),
          label: 'Statistics',
        ),
      ],
    );
  }
}
