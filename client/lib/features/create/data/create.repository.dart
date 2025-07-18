import 'dart:convert';

import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/shared/data/auth_http_client.dart';

class CreateRepository {
  final client = AuthHttpClient();

  void create() async {
    final deck = mockDeck();

    // TODO: improve the fetch itself
    final response = await client.post(
      Uri.parse('http://localhost:3000/authoring/decks'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(deck.toJson()),
    );

    // TODO: throw the correct error that comes from the server
    if (response.statusCode != 201) throw Exception('Failed to fetch decks.');
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
