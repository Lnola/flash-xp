import 'package:flashxp/shared/presentation/layout/flash_layout.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlashNotFound extends StatelessWidget {
  const FlashNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return FlashLayout(
      title: 'Not Found',
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oops! Page not found.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            FlashButton(
              onPressed: () => context.go('/home'),
              label: 'Go to Home',
              isBlock: true,
            ),
          ],
        ),
      ),
    );
  }
}
