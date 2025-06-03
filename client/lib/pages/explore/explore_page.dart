import 'package:flashxp/main.dart';
import 'package:flashxp/pages/explore/views/explore_view.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      title: 'Explore',
      body: ExploreView(),
    );
  }
}
