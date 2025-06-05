import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
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
