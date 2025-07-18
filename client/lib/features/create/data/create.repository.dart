import 'dart:convert';

import 'package:flashxp/features/create/data/create.api.dart';
import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/shared/helpers/result.dart';

class CreateRepository {
  final api = CreateApi();

  Future<Result<void>> createDeck() async {
    try {
      final deck = mockDeck();
      final response = await api.createDeck(deck);

      if (response.statusCode != 201) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        return Result.failure('Failed to create deck: $message');
      }
      return Result.success();
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  CreateDeckDto mockDeck() {
    return CreateDeckDto(
      title: 'New Deck',
      description: 'Description of the new deck',
      questions: [
        CreateQuestionDto(
          text: 'What is the capital of France?',
          answer: 'Paris',
          questionType: 'Self Assessment',
        ),
        CreateQuestionDto(
          text: 'What is 2 + 2?',
          questionType: 'Multiple Choice',
          answerOptions: [
            CreateAnswerOptionDto(text: '3', isCorrect: false),
            CreateAnswerOptionDto(text: '4', isCorrect: true),
            CreateAnswerOptionDto(text: '5', isCorrect: false),
          ],
        ),
      ],
    );
  }
}
