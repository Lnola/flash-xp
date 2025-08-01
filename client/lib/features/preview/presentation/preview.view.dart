import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flashxp/features/preview/data/preview.repository.dart';
import 'package:flashxp/features/preview/logic/preview.controller.dart';
import 'package:flashxp/features/preview/presentation/widgets/preview_info.widget.dart';
import 'package:flashxp/shared/helpers/confirmation_dialog.dart';
import 'package:flashxp/shared/helpers/result.dart';
import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flashxp/shared/presentation/widgets/flash_bookmark.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button_icon.dart';
import 'package:flashxp/shared/presentation/widgets/flash_loading.dart';
import 'package:flashxp/shared/presentation/widgets/utils/if.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class PreviewView extends StatefulWidget {
  final int deckId;

  const PreviewView({super.key, required this.deckId});

  @override
  State<PreviewView> createState() => PreviewViewState();
}

class PreviewViewState extends State<PreviewView> {
  late final PreviewController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = PreviewController(widget.deckId, PreviewRepository());
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
        useSnackbar(context, controller.error, 'Failed to load deck');
        context.replace('/404');
      });
      return const SizedBox.shrink();
    }

    if (controller.isLoading) {
      return const Center(child: FlashLoading());
    }

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.only(top: 8, bottom: 18),
      child: Column(
        spacing: 24,
        children: [
          _PreviewHeader(
            title: controller.title,
            description: controller.description,
          ),
          _PreviewQuestions(
            questions: controller.questions,
          ),
          _PreviewActions(
            deckId: widget.deckId,
            isBookmarked: controller.isBookmarked,
            toggleIsBookmarked: controller.toggleIsBookmarked,
            isCurrentUserAuthor: controller.isCurrentUserAuthor,
            forkDeck: controller.forkDeck,
            removeDeck: controller.removeDeck,
            handleToggleBookmark: controller.handleToggleBookmark,
          ),
        ],
      ),
    );
  }
}

class _PreviewHeader extends StatelessWidget {
  final String title;
  final String description;

  const _PreviewHeader({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        PreviewInfoWidget(
          label: 'Full title',
          content: title,
        ),
        PreviewInfoWidget(
          label: 'Description',
          content: description,
        ),
      ],
    );
  }
}

class _PreviewQuestions extends StatelessWidget {
  final List<QuestionDto> questions;

  const _PreviewQuestions({
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: List.generate(
        questions.length,
        (index) => PreviewInfoWidget(
          label: '#${index + 1}',
          content: questions[index].text,
        ),
      ),
    );
  }
}

class _PreviewActions extends StatelessWidget {
  final int deckId;
  final bool isBookmarked;
  final VoidCallback toggleIsBookmarked;
  final bool isCurrentUserAuthor;
  final Future<Result<int>> Function() forkDeck;
  final Future<Result<void>> Function() removeDeck;
  final Future<Result<void>> Function() handleToggleBookmark;

  const _PreviewActions({
    required this.deckId,
    required this.isBookmarked,
    required this.toggleIsBookmarked,
    required this.isCurrentUserAuthor,
    required this.forkDeck,
    required this.removeDeck,
    required this.handleToggleBookmark,
  });

  Future<void> _forkDeck(BuildContext context) async {
    final result = await forkDeck();
    if (!context.mounted) return;
    if (result.error != null) {
      return useSnackbar(context, result.error, 'Failed to fork deck');
    }
    useSnackbar(context, null, 'Deck successfully forked!');
    final newDeckId = result.data;
    context.replace('/authoring/$newDeckId/edit');
  }

  Future<void> _removeDeck(BuildContext context) async {
    final isConfirmed = await useConfirmationDialog(
      context,
      title: 'Remove deck',
      text: 'Are you sure you want to remove this deck?',
    );
    if (!isConfirmed) return;

    final result = await removeDeck();
    if (!context.mounted) return;
    if (result.error != null) {
      return useSnackbar(context, result.error, 'Failed to remove deck');
    }
    useSnackbar(context, null, 'Deck successfully removed!');
    context.replace('/home');
  }

  void _toggleBookmark(BuildContext context) async {
    final result = await handleToggleBookmark();
    if (!context.mounted) return;
    if (result.error != null) {
      return useSnackbar(context, result.error, 'Failed to toggle bookmark');
    }
    toggleIsBookmarked();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FlashButton(
                label: 'Start now',
                onPressed: () => context.push('/home/practice'),
                isBlock: true,
              ),
            ),
            FlashBookmark(
              isBookmarked: isBookmarked,
              onPressed: () => _toggleBookmark(context),
            ),
          ],
        ),
        If(
          condition: isCurrentUserAuthor,
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: FlashButton(
                  label: 'Edit deck',
                  onPressed: () => context.push('/authoring/$deckId/edit'),
                  isBlock: true,
                  isSecondary: true,
                ),
              ),
              Expanded(
                child: FlashButton(
                  label: 'Fork deck',
                  onPressed: () => _forkDeck(context),
                  isBlock: true,
                  isSecondary: true,
                ),
              ),
              FlashButtonIcon(
                icon: FontAwesomeIcons.trash,
                onPressed: () => _removeDeck(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
