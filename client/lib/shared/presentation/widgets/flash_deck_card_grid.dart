import 'package:flashxp/shared/data/dto/deck.dto.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card_skeleton.dart';
import 'package:flutter/material.dart';

class FlashDeckCardGrid extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final List<DeckDto> decks;
  final bool isLoading;

  const FlashDeckCardGrid({
    super.key,
    required this.title,
    this.backgroundColor,
    required this.decks,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        _GridLayout(
          decks: decks,
          backgroundColor: backgroundColor,
          isLoading: isLoading,
        ),
      ],
    );
  }
}

class _GridLayout extends StatelessWidget {
  final List<DeckDto> decks;
  final Color? backgroundColor;
  final bool isLoading;

  const _GridLayout({
    required this.decks,
    required this.backgroundColor,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth / 2) - 6;
        final cards = isLoading
            ? _buildDeckCardsSkeleton(cardWidth)
            : _buildDeckCards(cardWidth);

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards,
        );
      },
    );
  }

  List<Widget> _buildDeckCardsSkeleton(double cardWidth) {
    return List.generate(2, (_) => FlashDeckCardSkeleton(width: cardWidth));
  }

  List<Widget> _buildDeckCards(double cardWidth) {
    return decks
        .map(
          (deck) => FlashDeckCard(
            title: deck.title,
            totalQuestions: deck.totalQuestions,
            progress: deck.progress,
            mode: deck.mode,
            backgroundColor: backgroundColor,
            width: cardWidth,
          ),
        )
        .toList();
  }
}
