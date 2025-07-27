import 'dart:convert';

import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flashxp/shared/data/api/preview.api.dart';
import 'package:flashxp/shared/helpers/result.dart';

class PreviewRepository {
  final _previewApi = PreviewApi();

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
}
