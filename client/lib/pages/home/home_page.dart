import 'package:flashxp/main.dart';
import 'package:flashxp/pages/home/views/home_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      title: 'Home',
      body: HomeView(),
    );
  }
}
