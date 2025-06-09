import 'package:flashxp/features/preview/data/dto/deck.dto.dart';

class DeckRepository {
  Future<DeckDto> fetch() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDeck();
  }

  DeckDto _mockDeck() {
    return DeckDto(
      id: 1,
      title: 'Deck 1',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      isBookmarked: false,
      questions: [
        Question(
          id: 1,
          text:
              'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        Question(
          id: 2,
          text:
              'Question is: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        Question(
          id: 3,
          text: 'Question is: Short',
        ),
        Question(
          id: 4,
          text: 'Question is: Short',
        ),
      ],
    );
  }
}
