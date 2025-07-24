import 'package:flashxp/features/authoring/data/authoring.repository.dart';
import 'package:flashxp/features/authoring/data/dto/update_deck.dto.dart';
import 'package:flashxp/features/authoring/logic/base_authoring.controller.dart';
import 'package:flashxp/shared/helpers/result.dart';

class EditController extends BaseAuthoringController {
  final int deckId;
  final AuthoringRepository _authoringRepository;

  EditController(this.deckId, this._authoringRepository);

  @override
  Future<Result> submit() async {
    final updateQuestionsDto = super.strategy.mapQuestionControllersToDto();
    final updateDeckDto = UpdateDeckDto(
      title: titleController.text,
      description: descriptionController.text,
      questions: updateQuestionsDto,
    );
    return await _authoringRepository.updateDeck(deckId, updateDeckDto);
  }
}
