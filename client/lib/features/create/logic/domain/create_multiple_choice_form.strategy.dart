import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/create/logic/controllers/multiple_choice.controller.dart';
import 'package:flashxp/features/create/logic/domain/create_form.strategy.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';

class CreateMultipleChoiceFormStrategy implements CreateFormStrategy {
  final _formControllers = <MultipleChoiceController>[];

  @override
  List<MultipleChoiceController> get formControllers => _formControllers;

  @override
  void createQuestionControllers() {
    _formControllers.add(MultipleChoiceController());
  }

  @override
  void removeQuestionControllers(dynamic question) {
    final item = question as MultipleChoiceController;
    item.dispose();
    _formControllers.remove(item);
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
