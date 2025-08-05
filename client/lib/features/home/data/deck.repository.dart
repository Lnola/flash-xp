import 'dart:convert';

import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:flashxp/shared/data/dto/deck.dto.dart';

// TODO: Implement this the way other repositories do it
class DeckRepository {
  final client = AuthHttpClient();

  Future<List<DeckDto>> fetch({
    Map<String, String> params = const {},
  }) async {
    final uri = Uri.http(
      'localhost:3000',
      '/decks',
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
}
