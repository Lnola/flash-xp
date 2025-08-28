import 'package:flashxp/features/home/data/dto/deck.dto.dart';
import 'package:flashxp/features/home/data/home.repository.dart';
import 'package:flashxp/shared/data/models/catalog_deck.model.dart';
import 'package:flashxp/shared/helpers/result.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository _homeRepository;

  List<CatalogDeckModel> inProgressDecks = [];
  List<CatalogDeckModel> myDecks = [];
  List<CatalogDeckModel> savedDecks = [];
  bool isLoading = true;
  String? error;

  HomeController(this._homeRepository) {
    _initDecks();
  }

  Future<void> _initDecks() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final myDecksQueryParams = {'authored': 'true'};
    final savedDecksQueryParams = {'bookmarked': 'true'};
    try {
      inProgressDecks = await _getDecks(
        () => _homeRepository.getInProgressDecks(),
      );
      myDecks = await _getDecks(
        () => _homeRepository.getDecks(queryParams: myDecksQueryParams),
      );
      savedDecks = await _getDecks(
        () => _homeRepository.getDecks(queryParams: savedDecksQueryParams),
      );
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<List<CatalogDeckModel>> _getDecks(
    Future<Result<List<DeckDto>>> Function() fetchFunction,
  ) async {
    final result = await fetchFunction();
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
