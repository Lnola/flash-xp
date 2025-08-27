import 'package:flashxp/features/statistics/presentation/widgets/cards/question_summary_card.widget.dart';
import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flutter/material.dart';

class QuestionSummary {
  final int id;
  final String text;
  final int deckId;
  final String deckTitle;
  final int incorrectAnswerCount;

  const QuestionSummary({
    required this.id,
    required this.text,
    required this.deckId,
    required this.deckTitle,
    required this.incorrectAnswerCount,
  });
}

class QuestionSummaryListWidget extends StatelessWidget {
  final List<QuestionSummary>? items;
  final bool isLoading;
  final String? error;

  const QuestionSummaryListWidget({
    super.key,
    required this.items,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading || items == null) {
      return const _ListSkeleton();
    }

    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        useSnackbar(context, error, null);
      });
      return const SizedBox.shrink();
    }

    return Column(
      spacing: 12,
      children: items!
          .map(
            (q) => QuestionSummaryCardWidget(
              text: q.text,
              deckTitle: q.deckTitle,
              deckId: q.deckId,
              prefixNumber: q.incorrectAnswerCount,
            ),
          )
          .toList(),
    );
  }
}

class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (i) => const QuestionSummaryCardSkeleton()),
    );
  }
}
