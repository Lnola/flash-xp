import 'package:flashxp/shared/dto/deck.dto.dart';
import 'package:flashxp/shared/widgets/common/flash_card.dart';
import 'package:flutter/material.dart';

class FlashCardGrid extends StatelessWidget {
  final List<DeckDto> decks;

  const FlashCardGrid({
    super.key,
    required this.decks,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: decks
          .map(
            (deck) => FlashCard(
              title: deck.title,
              totalQuestions: deck.totalQuestions,
              progress: deck.progress,
              mode: deck.mode,
            ),
          )
          .toList(),
    );
  }
}
