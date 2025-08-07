// TODO: leverage feature related Dto instead of using this explore one
import 'package:flashxp/features/home/data/dto/deck.dto.dart';
import 'package:flashxp/features/home/data/home.repository.dart';
import 'package:flashxp/shared/data/models/catalog_deck.model.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository _homeRepository;

  List<CatalogDeckModel> inProgressDecks = [];
  List<CatalogDeckModel> myDecks = [];
  List<CatalogDeckModel> savedDecks = [];
  bool isLoading = true;

  HomeController(this._homeRepository) {
    _initDecks();
  }

  Future<void> _initDecks() async {
    isLoading = true;
    notifyListeners();

    try {
      inProgressDecks = await _getDecks();
      myDecks = await _getDecks(
        {'authored': 'true'},
      );
      savedDecks = await _getDecks(
        {'bookmarked': 'true'},
      );
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
    final result = await _homeRepository.getDecks(
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
