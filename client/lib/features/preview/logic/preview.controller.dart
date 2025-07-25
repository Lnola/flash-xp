import 'package:flashxp/features/preview/data/deck.repository.dart';
import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flutter/material.dart';

class PreviewController extends ChangeNotifier {
  final DeckRepository _deckRepository;

  late String title;
  late String description;
  late List<Question> questions;
  late bool isBookmarked;
  bool isLoading = true;

  PreviewController(this._deckRepository) {
    _initDeck();
  }

  Future<void> _initDeck() async {
    isLoading = true;
    notifyListeners();

    // TODO: replace with the real value
    final deck = await _deckRepository.fetch(1);
    title = deck.title;
    description = deck.description;
    questions = deck.questions;
    isBookmarked = deck.isBookmarked;

    isLoading = false;
    notifyListeners();
  }

  void toggleIsBookmarked() {
    // TODO: replace with the actual implementation through repository
    isBookmarked = !isBookmarked;
    notifyListeners();
  }
}
