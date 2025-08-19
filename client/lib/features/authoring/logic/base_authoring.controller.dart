import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flashxp/features/authoring/data/dto/deck.dto.dart';
import 'package:flashxp/features/authoring/logic/domain/multiple_choice_questions_controllers.strategy.dart';
import 'package:flashxp/features/authoring/logic/domain/questions_controllers.strategy.dart';
import 'package:flashxp/features/authoring/logic/domain/self_assessment_questions_controllers.strategy.dart';
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

class BaseAuthoringController extends ChangeNotifier {
  final AuthoringRepository _authoringRepository;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  PracticeMode mode = PracticeMode.multipleChoice;

  BaseAuthoringController(this._authoringRepository);

  final LazyStrategyManager _strategyManager = LazyStrategyManager();
  QuestionsControllersStrategy get strategy => _strategyManager.get(mode);

  void submit() {
    throw UnimplementedError('Submit method must be implemented in subclasses');
  }

  AuthoringRepository get authoringRepository => _authoringRepository;

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

  Future<File?> pickFile() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (picked == null || picked.files.single.path == null) return null;
    return File(picked.files.single.path!);
  }

  Future<Result<List<QuestionDto>>> generateQuestions() {
    throw UnimplementedError('Submit method must be implemented in subclasses');
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
