import 'dart:convert';
import 'dart:io';

import 'package:flashxp/features/authoring/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/authoring/data/dto/update_deck.dto.dart';
import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:http/http.dart' as http;

class AuthoringApi {
  final client = AuthHttpClient();

  Future<http.Response> getDeck(int deckId) {
    return client.get(client.buildUri('/authoring/decks/$deckId'));
  }

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

  Future<http.Response> forkDeck(int deckId) {
    return client.post(
      client.buildUri('/authoring/decks/$deckId/fork'),
    );
  }

  Future<http.Response> removeDeck(int deckId) {
    return client.delete(
      client.buildUri('/authoring/decks/$deckId'),
    );
  }

// TODO: extract the url and make this a get instead of post
  Future<http.Response> generateQuestions(String mode, File pdfFile) {
    return client.post(
      client.buildUri(
        '/generateQuestions',
        queryParams: {'type': mode},
        isCloudFunction: true,
      ),
      headers: {'Content-Type': 'application/pdf'},
      body: pdfFile.readAsBytesSync(),
    );
  }
}
