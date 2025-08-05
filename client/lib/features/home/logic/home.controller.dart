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

    try {
      inProgressDecks = await _deckRepository.fetch();
      myDecks = await _deckRepository.fetch(params: {'authored': 'true'});
      savedDecks = await _deckRepository.fetch(params: {'bookmarked': 'true'});
    } catch (e) {
      // TODO: Handle error by showing a toast
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}
