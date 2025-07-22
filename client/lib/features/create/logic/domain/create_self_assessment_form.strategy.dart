import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/logic/domain/create_form.strategy.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';

class CreateSelfAssessmentFormStrategy implements CreateFormStrategy {
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
