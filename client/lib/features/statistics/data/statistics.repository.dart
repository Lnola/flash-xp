import 'dart:convert';

import 'package:flashxp/features/statistics/logic/models/accuracy_rate.model.dart';
import 'package:flashxp/features/statistics/logic/models/daily_correct_incorrect.model.dart';
import 'package:flashxp/features/statistics/logic/models/incorrectly_answered_questions.model.dart';
import 'package:flashxp/features/statistics/logic/models/question_type_occurrence_count.model.dart';
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

  Future<Result<AccuracyRate>> getAccuracyRate() async {
    try {
      final response = await _statisticsApi.getAccuracyRate();
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure(message);
      }
      final data = jsonDecode(response.body);
      return Result.success(AccuracyRate.fromJson(data));
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<List<IncorrectlyAnsweredQuestions>>>
      getCommonIncorrectlyAnsweredQuestions() async {
    try {
      final response =
          await _statisticsApi.getCommonIncorrectlyAnsweredQuestions();
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure(message);
      }
      final data = (jsonDecode(response.body) as List)
          .map((item) => IncorrectlyAnsweredQuestions.fromJson(item))
          .toList();
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<QuestionTypeOccurrenceCount>>
      getQuestionTypeOccurrenceCount() async {
    try {
      final response = await _statisticsApi.getQuestionTypeOccurrenceCount();
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure(message);
      }
      final data =
          QuestionTypeOccurrenceCount.fromJson(jsonDecode(response.body));
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }
}
