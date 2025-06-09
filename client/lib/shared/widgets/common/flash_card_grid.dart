import 'package:flashxp/shared/widgets/common/flash_card.dart';
import 'package:flutter/material.dart';

class FlashCardGrid extends StatelessWidget {
  const FlashCardGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FlashCard(
          title: 'Long title lorem ipsum dolor sit amet',
          totalQuestions: 20,
          progress: 50,
          mode: FlashCardMode.multipleChoice,
        ),
        FlashCard(
          title: 'Short title',
          totalQuestions: 12,
          progress: 10,
          mode: FlashCardMode.multipleChoice,
        ),
        FlashCard(
          title: 'Short title',
          totalQuestions: 40,
          progress: 40,
          mode: FlashCardMode.selfAssessment,
        ),
        FlashCard(
          title: 'Long title lorem ipsum dolor sit amet',
          totalQuestions: 100,
          progress: 100,
          mode: FlashCardMode.selfAssessment,
        ),
      ],
    );
  }
}
