import 'package:flashxp/features/explore/data/deck.repository.dart';
import 'package:flashxp/shared/data/dto/deck.dto.dart';
import 'package:flutter/material.dart';

class ExploreController extends ChangeNotifier {
  final DeckRepository _deckRepository;

  List<DeckDto> multipleChoiceDecks = [];
  List<DeckDto> selfAssessmentDecks = [];
  List<DeckDto> popularDecks = [];
  List<DeckDto> forYouDecks = [];
  bool isLoading = true;

  ExploreController(this._deckRepository) {
    _initDecks();
  }

  Future<void> _initDecks() async {
    isLoading = true;
    notifyListeners(); // TODO: check if this notifyListeners() is needed

    multipleChoiceDecks = await _deckRepository.fetch();
    selfAssessmentDecks = await _deckRepository.fetch();
    popularDecks = await _deckRepository.fetch();
    forYouDecks = await _deckRepository.fetch();

    isLoading = false;
    notifyListeners();
  }
}
