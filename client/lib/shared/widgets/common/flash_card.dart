import 'package:flashxp/shared/widgets/common/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlashCard extends StatelessWidget {
  const FlashCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 216,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Short title',
            style: theme.textTheme.titleLarge?.copyWith(height: 1.2),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const FaIcon(FontAwesomeIcons.solidCircleQuestion, size: 16),
              const SizedBox(width: 8),
              Text('12 Questions', style: theme.textTheme.labelMedium),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const FaIcon(FontAwesomeIcons.listOl, size: 16),
              const SizedBox(width: 8),
              Text('Multiple Choice', style: theme.textTheme.labelMedium),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlashButton(label: 'Start now', onPressed: () {}),
              Text('40%', style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
