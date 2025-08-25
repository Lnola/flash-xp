import 'package:flashxp/shared/data/auth_http_client.dart';
import 'package:http/http.dart' as http;

class StatisticsApi {
  final client = AuthHttpClient();

  Future<http.Response> getDailyStreak() {
    return client.get(client.buildUri('/statistics/streak'));
  }

  Future<http.Response> getAnswerCount({
    Map<String, String> queryParams = const {},
  }) {
    return client.get(
      client.buildUri('/statistics/answer-count', queryParams: queryParams),
    );
  }
}
