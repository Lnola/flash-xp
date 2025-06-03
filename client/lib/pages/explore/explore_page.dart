import 'package:flashxp/pages/explore/views/explore_view.dart';
import 'package:flashxp/widgets/layout/flash_layout.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlashLayout(
      title: 'Explore',
      body: ExploreView(),
    );
  }
}
