import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/number_card_group.widget.dart';
import 'package:flutter/material.dart';

class AnswerCountGroupWidget extends StatelessWidget {
  final StatStore<int> answerCountToday;
  final StatStore<int> answerCountTotal;

  const AnswerCountGroupWidget({
    super.key,
    required this.answerCountToday,
    required this.answerCountTotal,
  });

  @override
  Widget build(BuildContext context) {
    return NumberCardGroupWidget(
      values: [
        answerCountToday.data.toString(),
        answerCountTotal.data.toString(),
      ],
      labels: ['Cards answered today', 'Total cards answered'],
    );
  }
}
