import 'dart:convert';
import 'dart:io';

import 'package:flashxp/features/authoring/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/authoring/data/dto/deck.dto.dart';
import 'package:flashxp/features/authoring/data/dto/update_deck.dto.dart';
import 'package:flashxp/shared/data/api/authoring.api.dart';
import 'package:flashxp/shared/helpers/result.dart';

class AuthoringRepository {
  final _authoringApi = AuthoringApi();

  Future<Result<DeckDto>> getDeck(int deckId) async {
    try {
      final response = await _authoringApi.getDeck(deckId);
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to fetch deck: $message');
      }
      final data = DeckDto.fromJson(jsonDecode(response.body));
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<void>> createDeck(CreateDeckDto dto) async {
    try {
      final response = await _authoringApi.createDeck(dto);
      if (response.statusCode != 201) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to create deck: $message');
      }
      return Result.success();
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<void>> updateDeck(int deckId, UpdateDeckDto dto) async {
    try {
      final response = await _authoringApi.updateDeck(deckId, dto);
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to edit deck: $message');
      }
      return Result.success();
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<List<QuestionDto>>> generateQuestions(
    String mode,
    File pdfFile,
  ) async {
    try {
      final response = await _authoringApi.generateQuestions(mode, pdfFile);
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to generate questions: $message');
      }
      final List<dynamic> jsonList = jsonDecode(response.body);
      final data = jsonList.map((it) => QuestionDto.fromJson(it)).toList();
      return Result.success(data);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }
}
