import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:http/http.dart' as http;

class PreviewApi {
  final client = AuthHttpClient();

  Future<http.Response> getDeck(int deckId) {
    return client.get(client.buildUri('/decks/$deckId'));
  }

  Future<http.Response> createBookmark(int deckId) {
    return client.post(client.buildUri('/decks/$deckId/bookmarks'));
  }

  Future<http.Response> removeBookmark(int deckId) {
    return client.delete(client.buildUri('/decks/$deckId/bookmarks'));
  }
}
