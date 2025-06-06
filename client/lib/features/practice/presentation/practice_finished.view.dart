import 'package:flashxp/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PracticeFinishedView extends StatelessWidget {
  const PracticeFinishedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Great job! You've completed the practice. Solve it again for the best learning results.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            FlashButton(
              onPressed: () => context.go('/home'),
              label: 'Return Home',
              isBlock: true,
            ),
          ],
        ),
      ),
    );
  }
}
