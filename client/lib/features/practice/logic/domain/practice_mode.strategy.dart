import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/logic/model/answer_option_button.model.dart';

abstract class PracticeModeStrategy {
  List<AnswerOptionButtonModel> createOptions({
    required void Function(String label) onPressed,
    List<AnswerOptionDto>? answerOptionDtos,
  });
  List<AnswerOptionButtonModel> updateOptions({
    required String label,
    required List<AnswerOptionButtonModel> answerOptionButtons,
  });
}
