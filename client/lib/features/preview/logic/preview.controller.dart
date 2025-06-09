import 'package:flashxp/features/preview/data/deck.repository.dart';
import 'package:flutter/material.dart';

class PreviewController extends ChangeNotifier {
  final DeckRepository _deckRepository;

  late String title;
  late String description;
  bool isLoading = true;

  PreviewController(this._deckRepository) {
    _initDeck();
  }

  Future<void> _initDeck() async {
    isLoading = true;

    final deck = await _deckRepository.fetch();
    title = deck.title;
    description = deck.description;

    isLoading = false;
    notifyListeners();
  }
}
