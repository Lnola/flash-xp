import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

class CreateController extends ChangeNotifier {
  final TextEditingController titleController;
  final List<TextEditingController> dynamicControllers;
  final List<(TextEditingController, TextEditingController)>
      selfAssessmentPairs;
  final List<(TextEditingController, List<TextEditingController>)>
      multipleChoiceQuestions;

  PracticeMode mode = PracticeMode.multipleChoice;

  CreateController()
      : titleController = TextEditingController(),
        dynamicControllers = [],
        selfAssessmentPairs = [],
        multipleChoiceQuestions = [];

  void submit() {
    print('Title: ${titleController.text}');
    print('Mode: ${mode.name}');
    if (mode == PracticeMode.selfAssessment) {
      for (int i = 0; i < selfAssessmentPairs.length; i++) {
        print('Q$i: ${selfAssessmentPairs[i].$1.text}');
        print('A$i: ${selfAssessmentPairs[i].$2.text}');
      }
    } else if (mode == PracticeMode.multipleChoice) {
      for (int i = 0; i < multipleChoiceQuestions.length; i++) {
        final question = multipleChoiceQuestions[i];
        print('Question $i: ${question.$1.text}');
        for (int j = 0; j < question.$2.length; j++) {
          print(
            'Option ${String.fromCharCode(65 + j)}: ${question.$2[j].text}',
          );
        }
      }
    } else {
      for (int i = 0; i < dynamicControllers.length; i++) {
        print('Dynamic Input $i: ${dynamicControllers[i].text}');
      }
    }
  }

  void addDynamicInput() {
    if (mode == PracticeMode.selfAssessment) {
      selfAssessmentPairs.add(
        (
          TextEditingController(),
          TextEditingController(),
        ),
      );
    } else if (mode == PracticeMode.multipleChoice) {
      multipleChoiceQuestions.add(
        (
          TextEditingController(),
          List.generate(4, (_) => TextEditingController()),
        ),
      );
    } else {
      dynamicControllers.add(TextEditingController());
    }
    notifyListeners();
  }

  void addMultipleChoiceQuestion() {
    multipleChoiceQuestions.add(
      (
        TextEditingController(),
        List.generate(4, (_) => TextEditingController()),
      ),
    );
    notifyListeners();
  }

  void removeDynamicInput(TextEditingController controller) {
    dynamicControllers.remove(controller);
    controller.dispose();
    notifyListeners();
  }

  void removeSelfAssessmentPair(
    (TextEditingController, TextEditingController) pair,
  ) {
    selfAssessmentPairs.remove(pair);
    pair.$1.dispose();
    pair.$2.dispose();
    notifyListeners();
  }

  void removeMultipleChoiceQuestion(
    (TextEditingController, List<TextEditingController>) question,
  ) {
    question.$1.dispose();
    for (final option in question.$2) {
      option.dispose();
    }
    multipleChoiceQuestions.remove(question);
    notifyListeners();
  }

  void updateMode(PracticeMode newMode) {
    mode = newMode;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    for (final controller in dynamicControllers) {
      controller.dispose();
    }
    for (final pair in selfAssessmentPairs) {
      pair.$1.dispose();
      pair.$2.dispose();
    }
    for (final question in multipleChoiceQuestions) {
      question.$1.dispose();
      for (final option in question.$2) {
        option.dispose();
      }
    }
    super.dispose();
  }
}
