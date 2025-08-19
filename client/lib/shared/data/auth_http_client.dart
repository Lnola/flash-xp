import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final String _baseUrl = 'http://localhost:3000';
  final String _cloudFunctionsUrl = 'http://127.0.0.1:5001/flashxp/us-central1';

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (request is http.Request && request.bodyBytes.isNotEmpty) {
      final contentType = request.headers['Content-Type'];
      if (contentType == null || contentType.startsWith('text/plain')) {
        request.headers['Content-Type'] = 'application/json';
      }
    }

    final user = FirebaseAuth.instance.currentUser;
    final idToken = await user?.getIdToken();
    if (idToken != null) request.headers['Authorization'] = 'Bearer $idToken';
    return _inner.send(request);
  }

  Uri buildUri(
    String path, {
    Map<String, String> queryParams = const {},
    bool isCloudFunction = false,
  }) {
    final baseUrl = isCloudFunction ? _cloudFunctionsUrl : _baseUrl;
    final uri = Uri.parse('$baseUrl$path');
    return uri.replace(queryParameters: queryParams);
  }
}
