import 'dart:convert';

import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/shared/data/auth_http_client.dart';

class CreateRepository {
  final client = AuthHttpClient();

  Future<void> create() async {
    try {
      final deck = mockDeck();
      final response = await client.post(
        client.buildUri('/authoring/decks'),
        body: jsonEncode(deck.toJson()),
      );

      if (response.statusCode != 201) {
        final message = jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw Exception('Failed to create deck: $message');
      }
    } catch (error) {
      rethrow;
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
