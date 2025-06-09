import 'package:flashxp/shared/presentation/widgets/common/flash_progress_bar.dart';
import 'package:flutter/material.dart';

class PracticeProgress extends StatelessWidget {
  final int current;
  final int total;

  const PracticeProgress({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = current / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FlashProgressBar(progress: progress),
        const SizedBox(height: 4),
        Text(
          '$current of $total',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
