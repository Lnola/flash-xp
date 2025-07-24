import 'package:flashxp/features/authoring/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/authoring/logic/controllers/multiple_choice.controller.dart';
import 'package:flashxp/features/authoring/logic/domain/questions_controllers.strategy.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';

class MultipleChoiceQuestionsControllersStrategy
    implements QuestionsControllersStrategy {
  final _questionsControllers = <MultipleChoiceController>[];

  @override
  List<MultipleChoiceController> get questionsControllers =>
      _questionsControllers;

  @override
  void addQuestionControllers() {
    _questionsControllers.add(MultipleChoiceController());
  }

  @override
  void removeQuestionControllers(dynamic question) {
    final item = question as MultipleChoiceController;
    item.dispose();
    _questionsControllers.remove(item);
  }

  @override
  List<CreateQuestionDto> mapQuestionControllersToDto() {
    final mappedControllers = _questionsControllers.map((controllers) {
      final questionControllers = controllers;
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
    });
    return mappedControllers.toList();
  }

  @override
  void toggleIsCorrect(dynamic question, int index) {
    final item = question as MultipleChoiceController;
    item.answerOptionsControllers[index].toggleIsCorrect();
  }

  @override
  void dispose() {
    for (final controller in _questionsControllers) {
      controller.dispose();
    }
  }

  @override
  void populateQuestionsControllers(List questions) {
    for (final question in questions as List<CreateQuestionDto>) {
      final controller = MultipleChoiceController();
      controller.questionController.text = question.text;
      for (final answerOption in question.answerOptions!) {
        final answerController = AnswerOptionControllers();
        answerController.text.text = answerOption.text;
        answerController.isCorrect = answerOption.isCorrect;
        controller.answerOptionsControllers.add(answerController);
      }
      _questionsControllers.add(controller);
    }
  }
}
