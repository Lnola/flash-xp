import 'dart:convert';

import 'package:flashxp/features/home/data/dto/deck.dto.dart';
import 'package:flashxp/shared/data/api/catalog.api.dart';
import 'package:flashxp/shared/helpers/result.dart';

class HomeRepository {
  final _catalogApi = CatalogApi();

  Future<Result<List<DeckDto>>> getDecks({
    Map<String, String> queryParams = const {},
  }) async {
    try {
      final response = await _catalogApi.getDecks(queryParams: queryParams);
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('$message');
      }
      final List<dynamic> jsonList = jsonDecode(response.body);
      final data = jsonList.map((it) => DeckDto.fromJson(it)).toList();
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<List<DeckDto>>> getInProgressDecks() async {
    try {
      final response = await _catalogApi.getInProgressDecks();
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('$message');
      }
      final List<dynamic> jsonList = jsonDecode(response.body);
      final data = jsonList.map((it) => DeckDto.fromJson(it)).toList();
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }
}
