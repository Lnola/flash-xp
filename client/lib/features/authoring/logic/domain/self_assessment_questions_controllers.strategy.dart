import 'package:flashxp/features/authoring/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/authoring/logic/controllers/self_assessment.controller.dart';
import 'package:flashxp/features/authoring/logic/domain/questions_controllers.strategy.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';

class SelfAssessmentQuestionsControllersStrategy
    implements QuestionsControllersStrategy {
  final _questionsControllers = <SelfAssessmentController>[];

  @override
  List<SelfAssessmentController> get questionsControllers =>
      _questionsControllers;

  @override
  void createQuestionControllers() {
    _questionsControllers.add(SelfAssessmentController());
  }

  @override
  void removeQuestionControllers(dynamic question) {
    final item = question as SelfAssessmentController;
    item.dispose();
    _questionsControllers.remove(item);
  }

  @override
  List<CreateQuestionDto> mapQuestionControllersToDto() {
    final mappedControllers = _questionsControllers.map((questionControllers) {
      return CreateQuestionDto(
        text: questionControllers.questionController.text,
        answer: questionControllers.answerController.text,
        questionType: PracticeMode.selfAssessment.label,
      );
    });
    return mappedControllers.toList();
  }

  @override
  void toggleIsCorrect(dynamic question, int index) {}

  @override
  void dispose() {
    for (final controller in _questionsControllers) {
      controller.dispose();
    }
  }
}
