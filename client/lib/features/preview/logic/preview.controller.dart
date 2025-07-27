import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flashxp/features/preview/data/preview.repository.dart';
import 'package:flutter/material.dart';

class PreviewController extends ChangeNotifier {
  final int deckId;
  final PreviewRepository _previewRepository;

  // TODO: think about replacing these fields with a model
  late String title;
  late String description;
  late List<QuestionDto> questions;
  late bool isBookmarked;
  late bool isCurrentUserAuthor;
  bool isLoading = true;
  String? error;

  PreviewController(this.deckId, this._previewRepository) {
    _initDeck();
  }

  Future<void> _initDeck() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _previewRepository.getDeck(deckId);
    if (result.error != null) {
      isLoading = false;
      error = result.error;
      notifyListeners();
      return;
    }
    final deck = result.data!;
    title = deck.title;
    description = deck.description;
    questions = deck.questions;
    isBookmarked = deck.isBookmarked;
    isCurrentUserAuthor = deck.isCurrentUserAuthor;

    isLoading = false;
    notifyListeners();
  }

  void toggleIsBookmarked() {
    // TODO: replace with the actual implementation through repository
    isBookmarked = !isBookmarked;
    notifyListeners();
  }
}
