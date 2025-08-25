import 'dart:convert';

import 'package:flashxp/features/statistics/logic/models/daily_correct_incorrect.model.dart';
import 'package:flashxp/shared/data/api/statistics.api.dart';
import 'package:flashxp/shared/helpers/result.dart';

class StatisticsRepository {
  final _statisticsApi = StatisticsApi();

  Future<Result<int>> getDailyStreak() async {
    try {
      final response = await _statisticsApi.getDailyStreak();
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure(message);
      }
      final data = jsonDecode(response.body);
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<int>> getAnswerCount({
    Map<String, String> queryParams = const {},
  }) async {
    try {
      final response = await _statisticsApi.getAnswerCount(
        queryParams: queryParams,
      );
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure(message);
      }
      final data = jsonDecode(response.body);
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<int>> getDeckCount({
    Map<String, String> queryParams = const {},
  }) async {
    try {
      final response = await _statisticsApi.getDeckCount(
        queryParams: queryParams,
      );
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure(message);
      }
      final data = jsonDecode(response.body);
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<List<DailyCorrectIncorrect>>> getDailyCorrectIncorrect() async {
    try {
      final response = await _statisticsApi.getDailyCorrectIncorrect();
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure(message);
      }
      final data = (jsonDecode(response.body) as List)
          .map((item) => DailyCorrectIncorrect.fromJson(item))
          .toList();
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }
}
