import 'package:flashxp/features/authoring/data/dto/create_deck.dto.dart';

abstract class QuestionsControllersStrategy {
  List<dynamic> get questionsControllers;

  void addQuestionControllers();
  void removeQuestionControllers(dynamic question);
  List<CreateQuestionDto> mapQuestionControllersToDto();
  void toggleIsCorrect(dynamic question, int index);
  void dispose();
}
