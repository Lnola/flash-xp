import 'package:flashxp/features/statistics/logic/models/incorrectly_answered_questions.model.dart';
import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/question_summary_card_list.widget.dart';
import 'package:flutter/material.dart';

class CommonIncorrectlyAnsweredQuestionsWidget extends StatelessWidget {
  final StatStore<List<IncorrectlyAnsweredQuestions>>
      incorrectlyAnsweredQuestions;

  const CommonIncorrectlyAnsweredQuestionsWidget({
    super.key,
    required this.incorrectlyAnsweredQuestions,
  });

  @override
  Widget build(BuildContext context) {
    if (incorrectlyAnsweredQuestions.data != null &&
        incorrectlyAnsweredQuestions.data!.isEmpty &&
        !incorrectlyAnsweredQuestions.isLoading) {
      return const SizedBox.shrink();
    }

    final items = incorrectlyAnsweredQuestions.data
        ?.map(
          (it) => QuestionSummary(
            id: it.id,
            text: it.text,
            deckId: it.deckId,
            deckTitle: it.deckTitle,
            incorrectAnswerCount: it.count,
          ),
        )
        .toList();
    return Column(
      children: [
        const _Legend(),
        const SizedBox(height: 12),
        QuestionSummaryListWidget(
          items: items,
          isLoading: incorrectlyAnsweredQuestions.isLoading,
          error: incorrectlyAnsweredQuestions.error,
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Questions you frequently get wrong.',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          'The number next to the deck title and question text is the total number of mistakes you made on that specific question.\nClick on the card below for an overview of the deck and practice.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
