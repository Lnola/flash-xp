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

    try {
      multipleChoiceDecks = await _getDecks(
        {'questionType': 'Multiple Choice'},
      );
      selfAssessmentDecks = await _getDecks(
        {'questionType': 'Self Assessment'},
      );
      popularDecks = await _getDecks(
        {'sort': 'popular'},
      );
      allDecks = await _getDecks();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<List<DeckDto>> _getDecks([Map<String, String>? queryParams]) async {
    final result = await _exploreRepository.getDecks(
      queryParams: queryParams ?? {},
    );
    if (result.error != null) throw Exception(result.error);
    return result.data!;
  }
}
