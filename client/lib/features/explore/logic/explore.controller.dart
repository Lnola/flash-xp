import 'package:flashxp/features/explore/data/dto/deck.dto.dart';
import 'package:flashxp/features/explore/data/explore.repository.dart';
import 'package:flutter/material.dart';

class ExploreController extends ChangeNotifier {
  final ExploreRepository _exploreRepository;

  List<DeckDto> multipleChoiceDecks = [];
  List<DeckDto> selfAssessmentDecks = [];
  List<DeckDto> popularDecks = [];
  List<DeckDto> allDecks = [];
  bool isLoading = true;
  String? error;

  ExploreController(this._exploreRepository) {
    _initDecks();
  }

  Future<void> _initDecks() async {
    isLoading = true;
    error = null;
    notifyListeners();

    // TODO: Clean this up
    final multipleChoiceResult = await _exploreRepository.getDecks(
      queryParams: {'questionType': 'Multiple Choice'},
    );
    if (multipleChoiceResult.error != null) {
      isLoading = false;
      error = multipleChoiceResult.error;
      notifyListeners();
      return;
    }
    multipleChoiceDecks = multipleChoiceResult.data!;
    final selfAssessmentResult = await _exploreRepository.getDecks(
      queryParams: {'questionType': 'Self Assessment'},
    );
    if (selfAssessmentResult.error != null) {
      isLoading = false;
      error = selfAssessmentResult.error;
      notifyListeners();
      return;
    }
    selfAssessmentDecks = selfAssessmentResult.data!;
    final popularResult = await _exploreRepository.getDecks(
      queryParams: {'sort': 'popular'},
    );
    if (popularResult.error != null) {
      isLoading = false;
      error = popularResult.error;
      notifyListeners();
      return;
    }
    popularDecks = popularResult.data!;
    final allResult = await _exploreRepository.getDecks();
    if (allResult.error != null) {
      isLoading = false;
      error = allResult.error;
      notifyListeners();
      return;
    }
    allDecks = allResult.data!;

    isLoading = false;
    notifyListeners();
  }
}
