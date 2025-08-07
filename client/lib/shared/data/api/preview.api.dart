import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:http/http.dart' as http;

class PreviewApi {
  final client = AuthHttpClient();

  Future<http.Response> getDeck(int deckId) {
    return client.get(client.buildUri('/catalog/decks/$deckId'));
  }

  Future<http.Response> createBookmark(int deckId) {
    return client.post(client.buildUri('/catalog/bookmarks/$deckId'));
  }

  Future<http.Response> removeBookmark(int deckId) {
    return client.delete(client.buildUri('/catalog/bookmarks/$deckId'));
  }
}
