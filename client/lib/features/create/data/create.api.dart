import 'dart:convert';

import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/create/data/dto/update_deck.dto.dart';
import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:http/http.dart' as http;

class CreateApi {
  final client = AuthHttpClient();

  Future<http.Response> createDeck(CreateDeckDto dto) {
    return client.post(
      client.buildUri('/authoring/decks'),
      body: jsonEncode(dto.toJson()),
    );
  }

  Future<http.Response> updateDeck(int deckId, UpdateDeckDto dto) {
    return client.put(
      client.buildUri('/authoring/decks/$deckId'),
      body: jsonEncode(dto.toJson()),
    );
  }
}
