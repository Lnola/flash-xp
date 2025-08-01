import 'package:flashxp/features/practice/data/dto/answer_option.dto.dart';
import 'package:flashxp/features/practice/logic/models/answer_option_button.model.dart';

abstract class PracticeModeStrategy {
  List<AnswerOptionButtonModel> createAnswerOptionButtons({
    required void Function(String label) onPressed,
    List<AnswerOptionDto>? answerOptionDtos,
  });
  List<AnswerOptionButtonModel> updateAnswerOptionButtons({
    required String label,
    required List<AnswerOptionButtonModel> answerOptionButtons,
  });
}
