import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode.strategy.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_button.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_list.dart';

class MultipleChoiceStrategy implements PracticeModeStrategy {
  @override
  List<OptionButtonData> createOptions({
    required void Function(String label) onPressed,
    List<AnswerOptionDto>? answerOptionDtos,
  }) {
    if (answerOptionDtos == null || answerOptionDtos.isEmpty) {
      throw ArgumentError(
        'MultipleChoiceStrategy options cannot be null or empty',
      );
    }
    return _mapDtosToOptionButtons(
      answerOptionDtos: answerOptionDtos,
      onPressed: (label) => onPressed(label),
    );
  }

  @override
  List<OptionButtonData> updateOptions({
    required String label,
    required List<OptionButtonData> options,
  }) {
    return options.map((option) {
      var state = PracticeOptionState.defaultState;
      if (option.isCorrect) {
        state = PracticeOptionState.correct;
      } else if (option.label == label) {
        state = PracticeOptionState.incorrect;
      }
      return option.copyWith(state: state, isDisabled: true);
    }).toList();
  }

  List<OptionButtonData> _mapDtosToOptionButtons({
    required List<AnswerOptionDto> answerOptionDtos,
    required void Function(String label) onPressed,
  }) {
    return answerOptionDtos.map((answerOptionDto) {
      return OptionButtonData(
        label: answerOptionDto.label,
        isCorrect: answerOptionDto.isCorrect,
        onPressed: () => onPressed(answerOptionDto.label),
      );
    }).toList();
  }
}
