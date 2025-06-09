import 'package:flashxp/features/preview/data/deck.repository.dart';
import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flashxp/features/preview/logic/preview.controller.dart';
import 'package:flashxp/features/preview/presentation/widgets/preview_info.widget.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flashxp/shared/presentation/widgets/flash_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreviewView extends StatefulWidget {
  const PreviewView({super.key});

  @override
  State<PreviewView> createState() => PreviewViewState();
}

class PreviewViewState extends State<PreviewView> {
  late final PreviewController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = PreviewController(DeckRepository());
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          _PreviewActions(),
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
          label: 'Title',
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
  final List<Question> questions;

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
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        FlashButton(
          label: 'Start now',
          onPressed: () => context.push('/home/practice'),
          isBlock: true,
        ),
        FlashButton(
          label: 'Edit deck',
          onPressed: () => context.push('/create/edit'),
          isBlock: true,
        ),
      ],
    );
  }
}
