import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();

    return Center(
      child: ElevatedButton(
        child: const Text('Push new page'),
        onPressed: () {
          context.push('$currentPath/nested');
        },
      ),
    );
  }
}
