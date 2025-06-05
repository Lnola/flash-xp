import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/logic/domain/practice_mode.strategy.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_button.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_list.dart';

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
