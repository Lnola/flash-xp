import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';

abstract class CreateQuestionsFormStrategy {
  List<dynamic> get questionsControllers;

  void createQuestionControllers();
  void removeQuestionControllers(dynamic question);
  List<CreateQuestionDto> mapQuestionControllersToDto();
  void toggleIsCorrect(dynamic question, int index);
  void dispose();
}
