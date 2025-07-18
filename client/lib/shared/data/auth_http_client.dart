import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final String _baseUrl = 'http://localhost:3000';

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final user = FirebaseAuth.instance.currentUser;
    final idToken = await user?.getIdToken();
    if (idToken != null) request.headers['Authorization'] = 'Bearer $idToken';
    return _inner.send(request);
  }

  Uri buildUri(String path) => Uri.parse('$_baseUrl$path');
}
