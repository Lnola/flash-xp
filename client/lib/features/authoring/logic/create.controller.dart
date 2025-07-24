import 'package:flashxp/features/authoring/data/authoring.repository.dart';
import 'package:flashxp/features/authoring/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/authoring/logic/base_authoring.controller.dart';
import 'package:flashxp/shared/helpers/result.dart';

class CreateController extends BaseAuthoringController {
  final AuthoringRepository _authoringRepository;

  CreateController(this._authoringRepository);

  @override
  Future<Result> submit() async {
    final createQuestionsDto = strategy.mapQuestionControllersToDto();
    final createDeckDto = CreateDeckDto(
      title: titleController.text,
      description: descriptionController.text,
      questions: createQuestionsDto,
    );
    return await _authoringRepository.createDeck(createDeckDto);
  }
}
