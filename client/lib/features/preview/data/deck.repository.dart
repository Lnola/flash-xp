import 'dart:convert';

import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flashxp/shared/data/auth_http_client.dart';

class DeckRepository {
  final client = AuthHttpClient();

  Future<DeckDto> fetch(int id) async {
    // TODO: improve the fetch itself
    final response =
        await client.get(Uri.parse('http://localhost:3000/decks/$id'));

    // TODO: throw the correct error that comes from the server
    if (response.statusCode != 200) throw Exception('Failed to fetch deck.');
    return parseDeck(response.body);
  }

  DeckDto parseDeck(String jsonString) {
    final dynamic response = json.decode(jsonString);
    return DeckDto.fromJson(response);
  }
}
