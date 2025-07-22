import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';

abstract class CreateFormStrategy {
  List<dynamic> get formControllers;

  void createQuestionControllers();
  void removeQuestionControllers(dynamic question);
  List<CreateQuestionDto> mapQuestionControllersToDto();
  void toggleIsCorrect(dynamic question, int index);
  void dispose();
}
