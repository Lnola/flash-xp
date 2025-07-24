import 'dart:convert';

import 'package:flashxp/features/authoring/data/create.api.dart';
import 'package:flashxp/features/authoring/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/authoring/data/dto/deck.dto.dart';
import 'package:flashxp/features/authoring/data/dto/update_deck.dto.dart';
import 'package:flashxp/shared/helpers/result.dart';

class CreateRepository {
  final api = CreateApi();

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

  Future<Result<void>> updateDeck(int deckId, UpdateDeckDto dto) async {
    try {
      final response = await api.updateDeck(deckId, dto);
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to edit deck: $message');
      }
      return Result.success();
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<void>> forkDeck(int deckId) async {
    try {
      final response = await api.forkDeck(deckId);
      if (response.statusCode != 201) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to fork deck: $message');
      }
      return Result.success();
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<Result<void>> removeDeck(int deckId) async {
    try {
      final response = await api.removeDeck(deckId);
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
