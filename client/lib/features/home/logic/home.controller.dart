import 'package:flashxp/features/home/data/deck.repository.dart';
import 'package:flashxp/shared/data/dto/deck.dto.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final DeckRepository _deckRepository;

  List<CatalogDeckModel> inProgressDecks = [];
  List<CatalogDeckModel> myDecks = [];
  List<CatalogDeckModel> savedDecks = [];
  bool isLoading = true;

  HomeController(this._deckRepository) {
    _initDecks();
  }

  Future<void> _initDecks() async {
    isLoading = true;
    notifyListeners();

    try {
      inProgressDecks = await _getDecks();
      myDecks = await _getDecks({'authored': 'true'});
      savedDecks = await _getDecks({'bookmarked': 'true'});
    } catch (e) {
      // TODO: Handle error by showing a toast
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<List<CatalogDeckModel>> _getDecks([
    Map<String, String>? queryParams,
  ]) async {
    final dtos = await _deckRepository.fetch(params: queryParams ?? {});
    return _mapDtosToModels(dtos);
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
