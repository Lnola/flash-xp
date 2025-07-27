import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flashxp/features/preview/data/preview.repository.dart';
import 'package:flutter/material.dart';

class PreviewController extends ChangeNotifier {
  final PreviewRepository _previewRepository;

  late String title;
  late String description;
  late List<Question> questions;
  late bool isBookmarked;
  bool isLoading = true;
  String? error;

  PreviewController(this._previewRepository) {
    _initDeck();
  }

  Future<void> _initDeck() async {
    isLoading = true;
    error = null;
    notifyListeners();

    // TODO: replace with the real value
    final result = await _previewRepository.getDeck(2);
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

    isLoading = false;
    notifyListeners();
  }

  void toggleIsBookmarked() {
    // TODO: replace with the actual implementation through repository
    isBookmarked = !isBookmarked;
    notifyListeners();
  }
}
