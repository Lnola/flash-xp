import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode.strategy.dart';
import 'package:flashxp/features/practice/logic/models/answer_option_button.model.dart';

class SelfAssessmentStrategy implements PracticeModeStrategy {
  @override
  List<AnswerOptionButtonModel> createAnswerOptionButtons({
    required void Function(String label) onPressed,
    List<AnswerOptionDto>? answerOptionDtos,
  }) {
    return [
      AnswerOptionButtonModel(
        label: "I don't know",
        onPressed: () => onPressed("I don't know"),
        state: AnswerOptionButtonState.incorrect,
      ),
      AnswerOptionButtonModel(
        label: 'I know',
        onPressed: () => onPressed('I know'),
        state: AnswerOptionButtonState.correct,
      ),
    ];
  }

  @override
  List<AnswerOptionButtonModel> updateAnswerOptionButtons({
    required String label,
    required List<AnswerOptionButtonModel> answerOptionButtons,
  }) {
    return answerOptionButtons;
  }
}
