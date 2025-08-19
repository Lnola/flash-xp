import 'package:flashxp/features/authoring/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/authoring/logic/base_authoring.controller.dart';
import 'package:flashxp/shared/helpers/result.dart';

class CreateController extends BaseAuthoringController {
  CreateController(super.authoringRepository);

  @override
  Future<Result> submit() async {
    final createQuestionsDto = strategy.mapQuestionControllersToDto();
    final createDeckDto = CreateDeckDto(
      title: titleController.text,
      description: descriptionController.text,
      questions: createQuestionsDto,
    );
    return await authoringRepository.createDeck(createDeckDto);
  }
}
