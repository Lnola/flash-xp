import 'package:flashxp/features/authoring/data/authoring.repository.dart';
import 'package:flashxp/features/authoring/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/authoring/data/dto/deck.dto.dart';
import 'package:flashxp/features/authoring/logic/base_authoring.controller.dart';
import 'package:flashxp/shared/helpers/result.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_client_label.extension.dart';

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

  @override
  Future<Result<List<QuestionDto>>> generateQuestions() async {
    final file = await pickFile();
    if (file == null) return Result.failure('No file selected');
    return _authoringRepository.generateQuestions(mode.label, file);
  }
}
