import 'dart:convert';

import 'package:flashxp/features/explore/data/dto/deck.dto.dart';
import 'package:flashxp/shared/data/api/catalog.api.dart';
import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:flashxp/shared/helpers/result.dart';

class DeckRepository {
  final _catalogApi = CatalogApi();

  final client = AuthHttpClient();

  Future<List<DeckDto>> fetch({
    Map<String, String> params = const {},
  }) async {
    final uri = Uri.http(
      'localhost:3000',
      '/catalog/decks',
      params,
    );
    final response = await client.get(uri);
    if (response.statusCode != 200) throw Exception('Failed to fetch decks.');
    return parseDecks(response.body);
  }

  List<DeckDto> parseDecks(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => DeckDto.fromJson(json)).toList();
  }

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
}
