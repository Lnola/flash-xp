import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/create/logic/domain/create_multiple_choice_form.strategy.dart';
import 'package:flashxp/features/create/logic/domain/create_questions_form.strategy.dart';
import 'package:flashxp/features/create/logic/domain/create_self_assessment_form.strategy.dart';
import 'package:flashxp/shared/helpers/result.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

class LazyStrategyResolver {
  final Map<PracticeMode, CreateQuestionsFormStrategy Function()>
      _strategyFactories = {
    PracticeMode.multipleChoice: () => CreateMultipleChoiceFormStrategy(),
    PracticeMode.selfAssessment: () => CreateSelfAssessmentFormStrategy(),
  };

  final _strategyCache = <PracticeMode, CreateQuestionsFormStrategy>{};

  CreateQuestionsFormStrategy get(PracticeMode mode) {
    return _strategyCache.putIfAbsent(mode, _strategyFactories[mode]!);
  }

  void dispose() {
    for (var strategy in _strategyCache.values) {
      strategy.dispose();
    }
    _strategyCache.clear();
  }
}

class CreateController extends ChangeNotifier {
  final CreateRepository _createRepository;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  PracticeMode mode = PracticeMode.multipleChoice;

  final LazyStrategyResolver _strategyManager = LazyStrategyResolver();
  CreateQuestionsFormStrategy get _strategy => _strategyManager.get(mode);

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

  List<dynamic> get questionsControllers => _strategy.questionsControllers;

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
    _strategyManager.dispose();
    super.dispose();
  }
}
