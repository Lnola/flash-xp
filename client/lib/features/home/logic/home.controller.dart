import 'package:flashxp/features/home/data/deck.repository.dart';
import 'package:flashxp/shared/data/dto/deck.dto.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final DeckRepository _deckRepository;

  List<DeckDto> inProgressDecks = [];
  List<DeckDto> myDecks = [];
  List<DeckDto> savedDecks = [];
  bool isLoading = true;

  HomeController(this._deckRepository) {
    _initDecks();
  }

  Future<void> _initDecks() async {
    isLoading = true;
    notifyListeners();

    inProgressDecks = await _deckRepository.fetch();
    myDecks = await _deckRepository.fetch();
    savedDecks = await _deckRepository.fetch();

    isLoading = false;
    notifyListeners();
  }
}
