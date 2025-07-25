import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/data/dto/create_deck.dto.dart';
import 'package:flashxp/features/create/logic/domain/multiple_choice_questions_controllers.strategy.dart';
import 'package:flashxp/features/create/logic/domain/questions_controllers.strategy.dart';
import 'package:flashxp/features/create/logic/domain/self_assessment_questions_controllers.strategy.dart';
import 'package:flashxp/shared/helpers/result.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

class LazyStrategyManager {
  final Map<PracticeMode, QuestionsControllersStrategy Function()>
      _strategyFactories = {
    PracticeMode.multipleChoice: () =>
        MultipleChoiceQuestionsControllersStrategy(),
    PracticeMode.selfAssessment: () =>
        SelfAssessmentQuestionsControllersStrategy(),
  };

  final _strategyCache = <PracticeMode, QuestionsControllersStrategy>{};

  QuestionsControllersStrategy get(PracticeMode mode) {
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

  final LazyStrategyManager _strategyManager = LazyStrategyManager();
  QuestionsControllersStrategy get _strategy => _strategyManager.get(mode);

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
