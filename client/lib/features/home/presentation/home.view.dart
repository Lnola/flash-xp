import 'package:flashxp/features/home/data/deck.repository.dart';
import 'package:flashxp/features/home/logic/home.controller.dart';
import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
    final authService = context.read<AuthService>();
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 32,
        children: [
          FlashButton(
            onPressed: () async {
              await authService.signOut();
              // TODO: Handle sign out properly
              context.go('/auth');
            },
            label: authService.user?.email ?? 'Sign Out',
          ),
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
