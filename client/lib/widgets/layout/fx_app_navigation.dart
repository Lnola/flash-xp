import 'package:flutter/material.dart';

class FxAppNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FxAppNavigation({
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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Statistics',
        ),
      ],
    );
  }
}
