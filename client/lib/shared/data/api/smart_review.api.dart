import 'dart:convert';

import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:http/http.dart' as http;

class SmartReviewApi {
  final client = AuthHttpClient();

  Future<http.Response> start(int deckId) {
    return client.post(client.buildUri('/practice/smart/decks/$deckId/boxes'));
  }

  Future<http.Response> getQuestions(int deckId) {
    return client.get(
      client.buildUri(
        '/practice/smart/decks/$deckId/questions',
      ),
    );
  }

  Future<http.Response> submitAnswer(int questionId, bool isCorrect) {
    return client.put(
      client.buildUri('/practice/smart/questions/$questionId/answer'),
      body: jsonEncode({'isCorrect': isCorrect}),
    );
  }
}
