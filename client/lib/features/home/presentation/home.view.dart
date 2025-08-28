import 'package:flashxp/features/home/data/home.repository.dart';
import 'package:flashxp/features/home/logic/home.controller.dart';
import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card_grid.dart';
import 'package:flutter/material.dart';

// TODO: show something if empty
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
    controller = HomeController(HomeRepository());
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.error != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        useSnackbar(context, controller.error, 'Failed to load decks.');
      });
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlashDeckCardGrid(
            title: 'In progress',
            decks: controller.inProgressDecks,
            isLoading: controller.isLoading,
          ),
          FlashDeckCardGrid(
            title: 'My decks',
            decks: controller.myDecks,
            isLoading: controller.isLoading,
          ),
          FlashDeckCardGrid(
            title: 'Saved',
            decks: controller.savedDecks,
            isLoading: controller.isLoading,
          ),
        ],
      ),
    );
  }
}
