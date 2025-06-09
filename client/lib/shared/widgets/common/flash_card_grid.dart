import 'package:flashxp/shared/dto/deck.dto.dart';
import 'package:flashxp/shared/widgets/common/flash_card.dart';
import 'package:flutter/material.dart';

class FlashCardGrid extends StatelessWidget {
  final DeckDto deck;

  const FlashCardGrid({
    super.key,
    required this.deck,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FlashCard(
          title: deck.title,
          totalQuestions: deck.totalQuestions,
          progress: deck.progress,
          mode: deck.mode,
        ),
        const FlashCard(
          title: 'Short title',
          totalQuestions: 12,
          progress: 10,
          mode: FlashCardMode.multipleChoice,
        ),
        const FlashCard(
          title: 'Short title',
          totalQuestions: 40,
          progress: 40,
          mode: FlashCardMode.selfAssessment,
        ),
        const FlashCard(
          title: 'Long title lorem ipsum dolor sit amet',
          totalQuestions: 100,
          progress: 100,
          mode: FlashCardMode.selfAssessment,
        ),
      ],
    );
  }
}
