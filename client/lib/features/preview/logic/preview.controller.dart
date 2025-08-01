import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flashxp/features/preview/data/preview.repository.dart';
import 'package:flashxp/shared/helpers/result.dart';
import 'package:flutter/material.dart';

class PreviewController extends ChangeNotifier {
  final int deckId;
  final PreviewRepository _previewRepository;

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

  void toggleIsBookmarked() async {
    isBookmarked = !isBookmarked;
    notifyListeners();
  }

  Future<Result<int>> forkDeck() async {
    return await _previewRepository.forkDeck(deckId);
  }

  Future<Result<void>> removeDeck() async {
    return await _previewRepository.removeDeck(deckId);
  }

  Future<Result<void>> handleToggleBookmark() async {
    final toggle = isBookmarked
        ? _previewRepository.removeBookmark
        : _previewRepository.createBookmark;
    return await toggle(deckId);
  }
}
