import 'package:flashxp/features/authoring/logic/domain/multiple_choice_questions_controllers.strategy.dart';
import 'package:flashxp/features/authoring/logic/domain/questions_controllers.strategy.dart';
import 'package:flashxp/features/authoring/logic/domain/self_assessment_questions_controllers.strategy.dart';
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

class BaseAuthoringController extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  PracticeMode mode = PracticeMode.multipleChoice;

  final LazyStrategyManager _strategyManager = LazyStrategyManager();
  QuestionsControllersStrategy get strategy => _strategyManager.get(mode);

  void submit() {
    throw UnimplementedError('Submit method must be implemented in subclasses');
  }

  List<dynamic> get questionsControllers => strategy.questionsControllers;

  void updateMode(PracticeMode newMode) {
    mode = newMode;
    notifyListeners();
  }

  void addQuestion() {
    strategy.addQuestionControllers();
    notifyListeners();
  }

  void removeQuestion(dynamic question) {
    strategy.removeQuestionControllers(question);
    notifyListeners();
  }

  void toggleIsCorrect(dynamic question, int index) {
    strategy.toggleIsCorrect(question, index);
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    _strategyManager.dispose();
    super.dispose();
  }

  void reset() {
    titleController.clear();
    descriptionController.clear();
    _strategyManager.dispose();
    notifyListeners();
  }
}
