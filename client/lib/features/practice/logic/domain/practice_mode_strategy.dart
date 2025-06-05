import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_button.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_list.dart';

abstract class PracticeModeStrategy {
  List<OptionButtonData> createOptions({
    required void Function(String label) onPressed,
    List<AnswerOption>? answerOptions,
  });
  List<OptionButtonData> updateOptions({
    required String label,
    required List<OptionButtonData> options,
  });
}

class SelfAssessmentStrategy implements PracticeModeStrategy {
  @override
  List<OptionButtonData> createOptions({
    required void Function(String label) onPressed,
    List<AnswerOption>? answerOptions,
  }) {
    return [
      OptionButtonData(
        label: "I don't know",
        onPressed: () => onPressed("I don't know"),
        state: PracticeOptionState.incorrect,
      ),
      OptionButtonData(
        label: 'I know',
        onPressed: () => onPressed('I know'),
        state: PracticeOptionState.correct,
      ),
    ];
  }

  @override
  List<OptionButtonData> updateOptions({
    required String label,
    required List<OptionButtonData> options,
  }) {
    return options;
  }
}

class MultipleChoiceStrategy implements PracticeModeStrategy {
  @override
  List<OptionButtonData> createOptions({
    required void Function(String label) onPressed,
    List<AnswerOption>? answerOptions,
  }) {
    if (answerOptions == null || answerOptions.isEmpty) {
      throw ArgumentError(
        'MultipleChoiceStrategy options cannot be null or empty',
      );
    }
    return _mapOptionsToOptionButtons(
      answerOptions: answerOptions,
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

  List<OptionButtonData> _mapOptionsToOptionButtons({
    required List<AnswerOption> answerOptions,
    required void Function(String label) onPressed,
  }) {
    return answerOptions.map((option) {
      return OptionButtonData(
        label: option.label,
        isCorrect: option.isCorrect,
        onPressed: () => onPressed(option.label),
      );
    }).toList();
  }
}
