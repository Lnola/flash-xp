import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/create/data/dto/deck.dto.dart';
import 'package:flashxp/features/create/data/dto/update_deck.dto.dart';
import 'package:flashxp/shared/helpers/result.dart';
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

class MultipleChoiceController {
  final TextEditingController questionController = TextEditingController();
  // TODO: merge the two under this one
  final List<TextEditingController> answerOptionsControllers =
      List.generate(4, (_) => TextEditingController());
  final List<bool> isCorrectAnswers = List.generate(4, (_) => false);

  void dispose() {
    questionController.dispose();
    for (final answerOption in answerOptionsControllers) {
      answerOption.dispose();
    }
  }
}

class SelfAssessmentController {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  void dispose() {
    questionController.dispose();
    answerController.dispose();
  }
}

abstract class PracticeModeStrategy {
  void createQuestionControllers(CreateController controller);
  void removeQuestionControllers(CreateController controller, dynamic question);
  CreateQuestionDto mapQuestionControllersToDto(dynamic controllers);
  void toggleIsCorrect(dynamic question, int index);
}

class MultipleChoiceStrategy implements PracticeModeStrategy {
  @override
  void createQuestionControllers(CreateController controller) {
    controller.multipleChoiceControllers.add(MultipleChoiceController());
  }

  @override
  void removeQuestionControllers(
    CreateController controller,
    dynamic question,
  ) {
    final item = question as MultipleChoiceController;
    item.dispose();
    controller.multipleChoiceControllers.remove(item);
  }

  @override
  CreateQuestionDto mapQuestionControllersToDto(dynamic controllers) {
    final questionControllers = controllers as MultipleChoiceController;
    final answerOptions = questionControllers.answerOptionsControllers
        .asMap()
        .entries
        .map((entry) {
      final index = entry.key;
      final answerOption = entry.value;
      return CreateAnswerOptionDto(
        text: answerOption.text,
        isCorrect: questionControllers.isCorrectAnswers[index],
      );
    }).toList();
    // TODO: add the enum label questionType
    return CreateQuestionDto(
      text: questionControllers.questionController.text,
      questionType: 'Multiple Choice',
      answerOptions: answerOptions,
    );
  }

  @override
  void toggleIsCorrect(dynamic question, int index) {
    final item = question as MultipleChoiceController;
    item.isCorrectAnswers[index] = !item.isCorrectAnswers[index];
  }
}

class SelfAssessmentStrategy implements PracticeModeStrategy {
  @override
  void createQuestionControllers(CreateController controller) {
    controller.selfAssessmentControllers.add(SelfAssessmentController());
  }

  @override
  void removeQuestionControllers(
    CreateController controller,
    dynamic question,
  ) {
    final item = question as SelfAssessmentController;
    item.dispose();
    controller.selfAssessmentControllers.remove(item);
  }

  @override
  CreateQuestionDto mapQuestionControllersToDto(dynamic controllers) {
    final questionControllers = controllers as SelfAssessmentController;
    // TODO: add the enum label questionType
    return CreateQuestionDto(
      text: questionControllers.questionController.text,
      answer: questionControllers.answerController.text,
      questionType: 'Self Assessment',
    );
  }

  @override
  void toggleIsCorrect(dynamic question, int index) {}
}

class CreateController extends ChangeNotifier {
  final CreateRepository _createRepository;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<SelfAssessmentController> selfAssessmentControllers = [];
  final List<MultipleChoiceController> multipleChoiceControllers = [];

  PracticeMode mode = PracticeMode.multipleChoice;

  CreateController(this._createRepository);

  PracticeModeStrategy get _strategy => switch (mode) {
        PracticeMode.multipleChoice => MultipleChoiceStrategy(),
        PracticeMode.selfAssessment => SelfAssessmentStrategy(),
      };

  Future<Result> submit() async {
    // TODO: think about abstracting this
    final controllers = switch (mode) {
      PracticeMode.multipleChoice => multipleChoiceControllers,
      PracticeMode.selfAssessment => selfAssessmentControllers,
    };
    final createQuestionsDto =
        controllers.map(_strategy.mapQuestionControllersToDto).toList();
    final createDeckDto = CreateDeckDto(
      title: titleController.text,
      description: descriptionController.text,
      questions: createQuestionsDto,
    );
    return await _createRepository.createDeck(createDeckDto);
  }

  void toggleIsCorrect(dynamic question, int index) {
    _strategy.toggleIsCorrect(question, index);
    notifyListeners();
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
    descriptionController.dispose();
    for (final question in selfAssessmentControllers) {
      question.dispose();
    }
    for (final question in multipleChoiceControllers) {
      question.dispose();
    }
    super.dispose();
  }
}
