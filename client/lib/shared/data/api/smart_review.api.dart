import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:http/http.dart' as http;

class SmartReviewApi {
  final client = AuthHttpClient();

  Future<http.Response> getQuestions(int deckId) {
    return client.get(
      client.buildUri(
        '/practice/smart/decks/$deckId/questions',
      ),
    );
  }
}
