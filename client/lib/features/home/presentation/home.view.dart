import 'package:flashxp/shared/data/dto/deck.dto.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card_grid.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card_swiper.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final decks = [
      DeckDto(
        id: 1,
        title: 'Long title lorem ipsum dolor sit amet',
        totalQuestions: 4,
        progress: 25,
        mode: PracticeMode.multipleChoice,
      ),
      DeckDto(
        id: 2,
        title: 'Short title',
        totalQuestions: 12,
        progress: 10,
        mode: PracticeMode.multipleChoice,
      ),
      DeckDto(
        id: 3,
        title: 'Short title',
        totalQuestions: 40,
        progress: 40,
        mode: PracticeMode.selfAssessment,
      ),
      DeckDto(
        id: 4,
        title: 'Long title lorem ipsum dolor sit amet',
        totalQuestions: 100,
        progress: 100,
        mode: PracticeMode.selfAssessment,
      ),
    ];

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          FlashDeckCardSwiper(
            title: 'Swiper',
            decks: decks,
          ),
          const SizedBox(height: 32),
          FlashDeckCardGrid(
            title: 'Grid',
            decks: decks,
          ),
        ],
      ),
    );
  }
}
