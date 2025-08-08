import 'dart:convert';

import 'package:flashxp/features/practice/data/dto/question.dto.dart';
import 'package:flashxp/shared/data/api/smart_review.api.dart';
import 'package:flashxp/shared/helpers/result.dart';

class SmartReviewRepository {
  final _smartReviewApi = SmartReviewApi();

  Future<Result<List<QuestionDto>>> getQuestions(int deckId) async {
    try {
      final response = await _smartReviewApi.getQuestions(deckId);
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure(message);
      }
      final List<dynamic> jsonList = jsonDecode(response.body);
      final data = jsonList.map((it) => QuestionDto.fromJson(it)).toList();
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }
}
