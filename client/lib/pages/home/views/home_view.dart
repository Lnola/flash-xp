import 'package:flutter/material.dart';
import 'package:flashxp/pages/home/views/practice_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Home main content"),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const PracticeView(),
              ),
            );
          },
          child: const Text("Go to Practice"),
        ),
      ],
    );
  }
}
