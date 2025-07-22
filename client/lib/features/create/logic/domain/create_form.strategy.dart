import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';

abstract class CreateFormStrategy {
  List<dynamic> get formControllers;

  void createQuestionControllers();
  void removeQuestionControllers(dynamic question);
  CreateQuestionDto mapQuestionControllersToDto(dynamic controllers);
  void toggleIsCorrect(dynamic question, int index);
  void dispose();
}
