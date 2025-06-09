import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

class CreateController extends ChangeNotifier {
  final TextEditingController titleController;
  final List<TextEditingController> dynamicControllers;
  final List<(TextEditingController, TextEditingController)>
      selfAssessmentPairs;

  PracticeMode mode = PracticeMode.multipleChoice;

  CreateController()
      : titleController = TextEditingController(),
        dynamicControllers = [],
        selfAssessmentPairs = [];

  void submit() {
    print('Title: ${titleController.text}');
    print('Mode: ${mode.name}');
    if (mode == PracticeMode.selfAssessment) {
      for (int i = 0; i < selfAssessmentPairs.length; i++) {
        print('Q$i: ${selfAssessmentPairs[i].$1.text}');
        print('A$i: ${selfAssessmentPairs[i].$2.text}');
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
    } else {
      dynamicControllers.add(TextEditingController());
    }
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
    super.dispose();
  }
}
