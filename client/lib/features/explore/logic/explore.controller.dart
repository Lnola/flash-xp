import 'package:flashxp/features/explore/data/dto/deck.dto.dart';
import 'package:flashxp/features/explore/data/explore.repository.dart';
import 'package:flashxp/shared/data/models/catalog_deck.model.dart';
import 'package:flutter/material.dart';

class ExploreController extends ChangeNotifier {
  final ExploreRepository _exploreRepository;

  List<CatalogDeckModel> multipleChoiceDecks = [];
  List<CatalogDeckModel> selfAssessmentDecks = [];
  List<CatalogDeckModel> popularDecks = [];
  List<CatalogDeckModel> allDecks = [];
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

  Future<List<CatalogDeckModel>> _getDecks([
    Map<String, String>? queryParams,
  ]) async {
    final result = await _exploreRepository.getDecks(
      queryParams: queryParams ?? {},
    );
    if (result.error != null) throw Exception(result.error);
    return _mapDtosToModels(result.data!);
  }

  List<CatalogDeckModel> _mapDtosToModels(List<DeckDto> dtos) {
    return dtos.map((dto) {
      return CatalogDeckModel(
        id: dto.id,
        title: dto.title,
        totalQuestions: dto.totalQuestions,
        progress: dto.progress,
        mode: dto.mode,
      );
    }).toList();
  }
}
