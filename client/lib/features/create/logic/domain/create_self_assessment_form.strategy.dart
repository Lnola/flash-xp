import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/create/logic/controllers/self_assessment.controller.dart';
import 'package:flashxp/features/create/logic/domain/create_form.strategy.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';

class CreateSelfAssessmentFormStrategy implements CreateFormStrategy {
  final _formControllers = <SelfAssessmentController>[];

  @override
  List<SelfAssessmentController> get formControllers => _formControllers;

  @override
  void createQuestionControllers() {
    _formControllers.add(SelfAssessmentController());
  }

  @override
  void removeQuestionControllers(dynamic question) {
    final item = question as SelfAssessmentController;
    item.dispose();
    _formControllers.remove(item);
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

  @override
  void dispose() {
    for (final controller in _formControllers) {
      controller.dispose();
    }
  }
}
