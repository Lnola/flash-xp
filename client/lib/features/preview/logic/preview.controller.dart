import 'package:flashxp/features/preview/data/deck.repository.dart';
import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flutter/material.dart';

class PreviewController extends ChangeNotifier {
  final DeckRepository _deckRepository;

  DeckDto? deck;
  bool isLoading = true;

  PreviewController(this._deckRepository) {
    _initDeck();
  }

  Future<void> _initDeck() async {
    isLoading = true;

    deck = await _deckRepository.fetch();

    isLoading = false;
  }
}
