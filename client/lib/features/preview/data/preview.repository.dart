import 'dart:convert';

import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flashxp/shared/data/api/authoring.api.dart';
import 'package:flashxp/shared/data/api/preview.api.dart';
import 'package:flashxp/shared/helpers/result.dart';

class PreviewRepository {
  final _previewApi = PreviewApi();
  final _authoringApi = AuthoringApi();

  Future<Result<DeckDto>> getDeck(int deckId) async {
    try {
      final response = await _previewApi.getDeck(deckId);
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

  Future<Result<int>> forkDeck(int deckId) async {
    try {
      final response = await _authoringApi.forkDeck(deckId);
      if (response.statusCode != 201) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to fork deck: $message');
      }
      final newDeckId = jsonDecode(response.body)['id'] as int;
      return Result.success(newDeckId);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<void>> removeDeck(int deckId) async {
    try {
      final response = await _authoringApi.removeDeck(deckId);
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to remove deck: $message');
      }
      return Result.success();
    } catch (error) {
      return Result.failure(error.toString());
    }
  }
}
