import 'package:flashxp/features/home/data/home.repository.dart';
import 'package:flashxp/features/home/logic/home.controller.dart';
import 'package:flashxp/shared/presentation/composables/snackbar.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flashxp/shared/presentation/widgets/flash_deck_card_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    if (!controller.isLoading &&
        controller.inProgressDecks.isEmpty &&
        controller.myDecks.isEmpty &&
        controller.savedDecks.isEmpty) {
      return const _EmptyPage();
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

class _EmptyPage extends StatelessWidget {
  const _EmptyPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome aboard!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Your home page is empty (for now)!\n\nStart exploring to find new content and come back to this page once you started practicing and creating decks.\n\nThey will be waiting for you here ;)',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(99),
              ),
        ),
        const SizedBox(height: 32),
        FlashButton(
          onPressed: () => context.go('/explore'),
          label: 'Start exploring decks',
          isBlock: true,
        ),
      ],
    );
  }
}
