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

  Future<http.Response> getDeckCount({
    Map<String, String> queryParams = const {},
  }) {
    return client.get(
      client.buildUri('/statistics/deck-count', queryParams: queryParams),
    );
  }

  Future<http.Response> getDailyCorrectIncorrect() {
    return client.get(client.buildUri('/statistics/daily-correct-incorrect'));
  }

  Future<http.Response> getAccuracyRate({
    Map<String, String> queryParams = const {},
  }) {
    return client.get(
      client.buildUri('/statistics/accuracy-rate', queryParams: queryParams),
    );
  }

  Future<http.Response> getCommonIncorrectlyAnsweredQuestions() {
    return client
        .get(client.buildUri('/statistics/common-incorrect-questions'));
  }

  Future<http.Response> getQuestionTypeOccurrenceCount() {
    return client
        .get(client.buildUri('/statistics/question-type-occurrence-count'));
  }
}
