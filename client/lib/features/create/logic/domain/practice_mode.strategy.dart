import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/create/logic/create.controller.dart';

abstract class PracticeModeStrategy {
  void createQuestionControllers(CreateController controller);
  void removeQuestionControllers(CreateController controller, dynamic question);
  CreateQuestionDto mapQuestionControllersToDto(dynamic controllers);
  void toggleIsCorrect(dynamic question, int index);
}
