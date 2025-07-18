import 'dart:convert';

import 'package:flashxp/features/create/data/create.api.dart';
import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/shared/helpers/result.dart';

class CreateRepository {
  final api = CreateApi();

  Future<Result<void>> createDeck(CreateDeckDto dto) async {
    try {
      final response = await api.createDeck(dto);
      if (response.statusCode != 201) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to create deck: $message');
      }
      return Result.success();
    } catch (error) {
      return Result.failure(error.toString());
    }
  }
}
