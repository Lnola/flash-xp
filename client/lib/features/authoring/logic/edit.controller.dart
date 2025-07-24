import 'package:flashxp/features/authoring/data/authoring.repository.dart';
import 'package:flashxp/features/authoring/data/dto/deck.dto.dart';
import 'package:flashxp/features/authoring/data/dto/update_deck.dto.dart';
import 'package:flashxp/features/authoring/logic/base_authoring.controller.dart';
import 'package:flashxp/shared/helpers/result.dart';

class EditController extends BaseAuthoringController {
  final int deckId;
  final AuthoringRepository _authoringRepository;

  EditController(this.deckId, this._authoringRepository);

  Future<Result> getDeck() async {
    return await _authoringRepository.getDeck(deckId);
  }

  void populateForm(DeckDto deckData) {
    titleController.text = deckData.title;
    descriptionController.text = deckData.description;
    strategy.populateQuestionsControllers(deckData.questions);
  }

  @override
  Future<Result> submit() async {
    final updateQuestionsDto = strategy.mapQuestionControllersToDto();
    final updateDeckDto = UpdateDeckDto(
      title: titleController.text,
      description: descriptionController.text,
      questions: updateQuestionsDto,
    );
    return await _authoringRepository.updateDeck(deckId, updateDeckDto);
  }
}
