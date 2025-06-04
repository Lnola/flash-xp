import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PracticeQuestion extends StatelessWidget {
  final String question;

  const PracticeQuestion({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(56),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Question',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            question,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tap to rotate card',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(77),
                      ),
                ),
                const SizedBox(width: 8),
                FaIcon(
                  FontAwesomeIcons.rotate,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
