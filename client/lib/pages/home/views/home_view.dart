import 'package:flashxp/state/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flashxp/pages/home/views/practice_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavigationState>().setTitle('Home');
    });

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
