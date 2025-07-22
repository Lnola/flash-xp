import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/shared/helpers/result.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';
import 'package:flutter/material.dart';

class AnswerOptionControllers {
  final TextEditingController text = TextEditingController();
  bool isCorrect = false;

  void toggleIsCorrect() {
    isCorrect = !isCorrect;
  }
}

class MultipleChoiceController {
  final TextEditingController questionController = TextEditingController();
  final List<AnswerOptionControllers> answerOptionsControllers =
      List.generate(4, (_) => AnswerOptionControllers());

  void dispose() {
    questionController.dispose();
    for (final answerOption in answerOptionsControllers) {
      answerOption.text.dispose();
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
    final answerOptions = questionControllers.answerOptionsControllers.map(
      (answerOption) => CreateAnswerOptionDto(
        text: answerOption.text.text,
        isCorrect: answerOption.isCorrect,
      ),
    );

    return CreateQuestionDto(
      text: questionControllers.questionController.text,
      questionType: PracticeMode.multipleChoice.label,
      answerOptions: answerOptions.toList(),
    );
  }

  @override
  void toggleIsCorrect(dynamic question, int index) {
    final item = question as MultipleChoiceController;
    item.answerOptionsControllers[index].toggleIsCorrect();
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
    return CreateQuestionDto(
      text: questionControllers.questionController.text,
      answer: questionControllers.answerController.text,
      questionType: PracticeMode.selfAssessment.label,
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
