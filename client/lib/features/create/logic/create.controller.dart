import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/data/dto/deck.dto.dart';
import 'package:flashxp/features/create/data/dto/update_deck.dto.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

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
          questionType: 'Self Assessment',
        ),
        QuestionDto(
          text: 'What is 2 + 2?',
          questionType: 'Multiple Choice',
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
          questionType: 'Self Assessment',
        ),
        QuestionDto(
          text: 'What is 2 + 2?',
          questionType: 'Multiple Choice',
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

abstract class PracticeModeStrategy {
  void createQuestionControllers(CreateController controller);
  void removeQuestionControllers(CreateController controller, dynamic question);
}

class MultipleChoiceStrategy implements PracticeModeStrategy {
  @override
  void createQuestionControllers(CreateController controller) {
    controller.multipleChoiceControllers.add(
      (
        TextEditingController(),
        List.generate(4, (_) => TextEditingController()),
      ),
    );
  }

  @override
  void removeQuestionControllers(
    CreateController controller,
    dynamic question,
  ) {
    final item = question as MultipleChoiceController;
    item.$1.dispose();
    for (final option in item.$2) {
      option.dispose();
    }
    controller.multipleChoiceControllers.remove(item);
  }
}

class SelfAssessmentStrategy implements PracticeModeStrategy {
  @override
  void createQuestionControllers(CreateController controller) {
    controller.selfAssessmentControllers.add(
      (
        TextEditingController(),
        TextEditingController(),
      ),
    );
  }

  @override
  void removeQuestionControllers(
    CreateController controller,
    dynamic question,
  ) {
    final pair = question as SelfAssessmentController;
    pair.$1.dispose();
    pair.$2.dispose();
    controller.selfAssessmentControllers.remove(pair);
  }
}

typedef SelfAssessmentController = (
  TextEditingController,
  TextEditingController,
);
typedef MultipleChoiceController = (
  TextEditingController,
  List<TextEditingController>
);

class CreateController extends ChangeNotifier {
  final CreateRepository _createRepository;

  final TextEditingController titleController = TextEditingController();
  final List<SelfAssessmentController> selfAssessmentControllers = [];
  final List<MultipleChoiceController> multipleChoiceControllers = [];

  PracticeMode mode = PracticeMode.multipleChoice;

  CreateController(this._createRepository);

  PracticeModeStrategy get _strategy => switch (mode) {
        PracticeMode.multipleChoice => MultipleChoiceStrategy(),
        PracticeMode.selfAssessment => SelfAssessmentStrategy(),
      };

  void submit() async {
    Temp.remove(_createRepository, 19);
    // print('Title: ${titleController.text}');
    // print('Mode: ${mode.name}');
    // if (mode == PracticeMode.selfAssessment) {
    //   for (int i = 0; i < selfAssessmentControllers.length; i++) {
    //     print('Q$i: ${selfAssessmentControllers[i].$1.text}');
    //     print('A$i: ${selfAssessmentControllers[i].$2.text}');
    //   }
    // } else if (mode == PracticeMode.multipleChoice) {
    //   for (int i = 0; i < multipleChoiceControllers.length; i++) {
    //     final question = multipleChoiceControllers[i];
    //     print('Question $i: ${question.$1.text}');
    //     for (int j = 0; j < question.$2.length; j++) {
    //       print(
    //         'Option ${String.fromCharCode(65 + j)}: ${question.$2[j].text}',
    //       );
    //     }
    //   }
    // }
  }

  void addQuestion() {
    _strategy.createQuestionControllers(this);
    notifyListeners();
  }

  void removeQuestion(dynamic question) {
    _strategy.removeQuestionControllers(this, question);
    notifyListeners();
  }

  void updateMode(PracticeMode newMode) {
    mode = newMode;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    for (final pair in selfAssessmentControllers) {
      pair.$1.dispose();
      pair.$2.dispose();
    }
    for (final question in multipleChoiceControllers) {
      question.$1.dispose();
      for (final answerOption in question.$2) {
        answerOption.dispose();
      }
    }
    super.dispose();
  }
}
