import 'package:flashxp/features/home/data/deck.repository.dart';
import 'package:flashxp/features/home/logic/home.controller.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card_grid.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card_swiper.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = HomeController(DeckRepository());
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
        children: [
          FlashDeckCardSwiper(
            title: 'Swiper',
            decks: controller.decks,
          ),
          const SizedBox(height: 32),
          FlashDeckCardGrid(
            title: 'Grid',
            decks: controller.decks,
          ),
        ],
      ),
    );
  }
}
