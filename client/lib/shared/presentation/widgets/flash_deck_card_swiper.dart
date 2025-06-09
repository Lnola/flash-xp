import 'package:flashxp/shared/data/dto/deck.dto.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card.dart';
import 'package:flutter/material.dart';

class FlashDeckCardSwiper extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final List<DeckDto> decks;

  const FlashDeckCardSwiper({
    super.key,
    required this.title,
    this.backgroundColor,
    required this.decks,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: decks
                  .map(
                    (deck) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: FlashDeckCard(
                        title: deck.title,
                        totalQuestions: deck.totalQuestions,
                        progress: deck.progress,
                        mode: deck.mode,
                        backgroundColor: backgroundColor,
                        width: (constraints.maxWidth / 2) - 6,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
