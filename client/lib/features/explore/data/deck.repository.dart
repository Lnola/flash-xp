import 'dart:convert';

import 'package:flashxp/shared/data/dto/deck.dto.dart';
import 'package:http/http.dart' as http;

class DeckRepository {
  Future<List<DeckDto>> fetch() async {
    // TODO: improve the fetch itself
    final response = await http.get(Uri.parse('http://localhost:3000/decks'));

    // TODO: throw the correct error that comes from the server
    if (response.statusCode != 200) throw Exception('Failed to fetch decks.');
    return parseDecks(response.body);
  }

  List<DeckDto> parseDecks(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => DeckDto.fromJson(json)).toList();
  }
}
