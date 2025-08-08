import 'dart:convert';

import 'package:flashxp/features/practice/data/dto/question.dto.dart';
import 'package:flashxp/shared/data/api/quick_practice.api.dart';
import 'package:flashxp/shared/helpers/result.dart';

class QuestionRepository {
  final _quickPracticeApi = QuickPracticeApi();

  Future<Result<List<QuestionDto>>> getQuestions(int deckId) async {
    try {
      final response = await _quickPracticeApi.getQuestions(deckId);
      if (response.statusCode != 200) {
        return Result.failure(response.body);
      }
      final List<dynamic> jsonList = jsonDecode(response.body);
      final data = jsonList.map((it) => QuestionDto.fromJson(it)).toList();
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }
}
