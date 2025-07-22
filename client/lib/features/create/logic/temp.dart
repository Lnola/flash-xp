import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/data/dto/deck.dto.dart';
import 'package:flashxp/features/create/data/dto/update_deck.dto.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';

// TODO: remove this class
class Temp {
  static Future<void> get(CreateRepository createRepository, int deckId) async {
    final result = await createRepository.getDeck(deckId);
    print(result.error ?? 'Deck fetched successfully ${result.data?.title}');
  }

  static Future<void> create(CreateRepository createRepository) async {
    final mockDeck = DeckDto(
      title: 'New Deck',
      description: 'Description of the new deck',
      questions: [
        QuestionDto(
          text: 'What is the capital of France?',
          answer: 'Paris',
          questionType: PracticeMode.selfAssessment.label,
        ),
        QuestionDto(
          text: 'What is 2 + 2?',
          questionType: PracticeMode.multipleChoice.label,
          answerOptions: [
            UpdateAnswerOptionDto(text: '3', isCorrect: false),
            UpdateAnswerOptionDto(text: '4', isCorrect: true),
            UpdateAnswerOptionDto(text: '5', isCorrect: false),
          ],
        ),
      ],
    );

    final result = await createRepository.createDeck(mockDeck);
    print(result.error ?? 'Deck created successfully');
  }

  static Future<void> update(
    CreateRepository createRepository,
    int deckId,
  ) async {
    final mockDeck = DeckDto(
      title: 'Update New Deck',
      description: 'Update Description of the new deck',
      questions: [
        QuestionDto(
          text: 'Update What is the capital of France?',
          answer: 'Paris',
          questionType: PracticeMode.selfAssessment.label,
        ),
        QuestionDto(
          text: 'What is 2 + 2?',
          questionType: PracticeMode.multipleChoice.label,
          answerOptions: [
            UpdateAnswerOptionDto(text: '3', isCorrect: false),
            UpdateAnswerOptionDto(text: '4', isCorrect: true),
            UpdateAnswerOptionDto(text: '5', isCorrect: false),
          ],
        ),
      ],
    );

    final result = await createRepository.updateDeck(deckId, mockDeck);
    print(result.error ?? 'Deck edited successfully');
  }

  static Future<void> fork(
    CreateRepository createRepository,
    int deckId,
  ) async {
    final result = await createRepository.forkDeck(deckId);
    print(result.error ?? 'Deck forked successfully');
  }

  static Future<void> remove(
    CreateRepository createRepository,
    int deckId,
  ) async {
    final result = await createRepository.removeDeck(deckId);
    print(result.error ?? 'Deck removed successfully');
  }
}
