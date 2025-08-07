import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:http/http.dart' as http;

class CatalogApi {
  final client = AuthHttpClient();

  Future<http.Response> getDecks({Map<String, String> queryParams = const {}}) {
    final uri = client.buildUri('/catalog/decks/', queryParams: queryParams);
    return client.get(uri);
  }
}
