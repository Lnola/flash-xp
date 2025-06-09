import 'package:flashxp/shared/data/dto/deck.dto.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card.dart';
import 'package:flutter/material.dart';

class FlashDeckCardGrid extends StatelessWidget {
  final String title;
  final List<DeckDto> decks;

  const FlashDeckCardGrid({
    super.key,
    required this.title,
    required this.decks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: decks
              .map(
                (deck) => FlashDeckCard(
                  title: deck.title,
                  totalQuestions: deck.totalQuestions,
                  progress: deck.progress,
                  mode: deck.mode,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
