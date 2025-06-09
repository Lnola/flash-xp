import 'package:flashxp/features/explore/data/deck.repository.dart';
import 'package:flashxp/features/explore/logic/explore.controller.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card_swiper.dart';
import 'package:flutter/material.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => ExploreViewState();
}

class ExploreViewState extends State<ExploreView> {
  late final ExploreController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = ExploreController(DeckRepository());
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 32,
        children: [
          FlashDeckCardSwiper(
            title: 'Multiple choice',
            decks: controller.multipleChoiceDecks,
            isLoading: controller.isLoading,
            backgroundColor: Theme.of(context).colorScheme.surfaceBright,
          ),
          FlashDeckCardSwiper(
            title: 'Flashcards',
            decks: controller.selfAssessmentDecks,
            isLoading: controller.isLoading,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
          FlashDeckCardSwiper(
            title: 'Popular',
            decks: controller.popularDecks,
            isLoading: controller.isLoading,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          FlashDeckCardSwiper(
            title: 'For You',
            decks: controller.forYouDecks,
            isLoading: controller.isLoading,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
