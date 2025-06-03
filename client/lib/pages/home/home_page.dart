import 'package:flashxp/pages/home/views/home_view.dart';
import 'package:flashxp/widgets/layout/flash_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlashLayout(
      title: 'Home',
      body: HomeView(),
    );
  }
}
