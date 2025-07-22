import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/create/logic/controllers/multiple_choice.controller.dart';
import 'package:flashxp/features/create/logic/controllers/self_assessment.controller.dart';
import 'package:flashxp/features/create/logic/domain/create_form.strategy.dart';
import 'package:flashxp/features/create/logic/domain/create_multiple_choice_form.strategy.dart';
import 'package:flashxp/features/create/logic/domain/create_self_assessment_form.strategy.dart';
import 'package:flashxp/shared/helpers/result.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

class CreateController extends ChangeNotifier {
  final CreateRepository _createRepository;
  PracticeMode mode = PracticeMode.multipleChoice;

  final Map<PracticeMode, CreateFormStrategy Function()> _strategyFactories = {
    PracticeMode.multipleChoice: () => CreateMultipleChoiceFormStrategy(),
    PracticeMode.selfAssessment: () => CreateSelfAssessmentFormStrategy(),
  };
  final _strategyCache = <PracticeMode, CreateFormStrategy>{};
  CreateFormStrategy get _strategy =>
      _strategyCache.putIfAbsent(mode, _strategyFactories[mode]!);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  CreateController(this._createRepository);

  Future<Result> submit() async {
    final createQuestionsDto = _strategy.mapQuestionControllersToDto();
    final createDeckDto = CreateDeckDto(
      title: titleController.text,
      description: descriptionController.text,
      questions: createQuestionsDto,
    );
    return await _createRepository.createDeck(createDeckDto);
  }

  void updateMode(PracticeMode newMode) {
    mode = newMode;
    notifyListeners();
  }

  void addQuestion() {
    _strategy.createQuestionControllers();
    notifyListeners();
  }

  void removeQuestion(dynamic question) {
    _strategy.removeQuestionControllers(question);
    notifyListeners();
  }

  void toggleIsCorrect(dynamic question, int index) {
    _strategy.toggleIsCorrect(question, index);
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    _strategy.dispose();
    super.dispose();
  }
}
