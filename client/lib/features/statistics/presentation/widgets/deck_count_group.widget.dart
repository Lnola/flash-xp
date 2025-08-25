import 'package:flashxp/features/statistics/logic/statistics.controller.dart';
import 'package:flashxp/features/statistics/presentation/widgets/cards/number_card_group.widget.dart';
import 'package:flutter/material.dart';

class DeckCountGroupWidget extends StatelessWidget {
  final StatStore<int> deckCountToday;
  final StatStore<int> deckCountTotal;

  const DeckCountGroupWidget({
    super.key,
    required this.deckCountToday,
    required this.deckCountTotal,
  });

  @override
  Widget build(BuildContext context) {
    return NumberCardGroupWidget(
      groups: [
        NumberCardGroup(
          value: deckCountToday.data.toString(),
          isLoading: deckCountToday.isLoading,
          label: 'Decks solved today',
        ),
        NumberCardGroup(
          value: deckCountTotal.data.toString(),
          isLoading: deckCountTotal.isLoading,
          label: 'Total decks solved',
        ),
      ],
    );
  }
}
