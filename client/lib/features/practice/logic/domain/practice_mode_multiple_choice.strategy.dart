import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode.strategy.dart';
import 'package:flashxp/features/practice/logic/model/answer_option_button.model.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_button.dart';

class MultipleChoiceStrategy implements PracticeModeStrategy {
  @override
  List<AnswerOptionButtonModel> createOptions({
    required void Function(String label) onPressed,
    List<AnswerOptionDto>? answerOptionDtos,
  }) {
    if (answerOptionDtos == null || answerOptionDtos.isEmpty) {
      throw ArgumentError(
        'MultipleChoiceStrategy options cannot be null or empty',
      );
    }
    return _mapDtosToButtonModels(
      answerOptionDtos: answerOptionDtos,
      onPressed: (label) => onPressed(label),
    );
  }

  @override
  List<AnswerOptionButtonModel> updateOptions({
    required String label,
    required List<AnswerOptionButtonModel> answerOptionButtons,
  }) {
    return answerOptionButtons.map((option) {
      var state = PracticeOptionState.defaultState;
      if (option.isCorrect) {
        state = PracticeOptionState.correct;
      } else if (option.label == label) {
        state = PracticeOptionState.incorrect;
      }
      return option.copyWith(state: state, isDisabled: true);
    }).toList();
  }

  List<AnswerOptionButtonModel> _mapDtosToButtonModels({
    required List<AnswerOptionDto> answerOptionDtos,
    required void Function(String label) onPressed,
  }) {
    return answerOptionDtos.map((answerOptionDto) {
      return AnswerOptionButtonModel(
        label: answerOptionDto.label,
        isCorrect: answerOptionDto.isCorrect,
        onPressed: () => onPressed(answerOptionDto.label),
      );
    }).toList();
  }
}
