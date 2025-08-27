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
    final items = incorrectlyAnsweredQuestions.data
        ?.map(
          (it) => QuestionSummary(
            id: it.id,
            text: it.text,
            deckTitle: it.deckTitle,
            incorrectAnswerCount: it.count,
          ),
        )
        .toList();
    return QuestionSummaryListWidget(
      items: items,
      isLoading: incorrectlyAnsweredQuestions.isLoading,
      error: incorrectlyAnsweredQuestions.error,
    );
  }
}
