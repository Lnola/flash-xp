import 'dart:convert';

import 'package:flashxp/features/preview/data/dto/deck.dto.dart';
import 'package:flashxp/features/preview/data/preview.api.dart';
import 'package:flashxp/shared/helpers/result.dart';

class PreviewRepository {
  final api = PreviewApi();

  Future<Result<DeckDto>> getDeck(int deckId) async {
    try {
      final response = await api.getDeck(deckId);
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
