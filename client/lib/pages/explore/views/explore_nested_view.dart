import 'package:flashxp/pages/explore/views/explore_view.dart';
import 'package:flashxp/widgets/layout/flash_layout.dart';
import 'package:flutter/material.dart';

class ExploreNestedView extends StatelessWidget {
  const ExploreNestedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlashLayout(
      title: 'Explore Nested Page',
      body: ExploreView(),
    );
  }
}
