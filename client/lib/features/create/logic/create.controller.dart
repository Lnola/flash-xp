import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flutter/material.dart';

class CreateController extends ChangeNotifier {
  final TextEditingController titleController;
  final List<TextEditingController> dynamicControllers;

  PracticeMode mode = PracticeMode.multipleChoice;

  CreateController()
      : titleController = TextEditingController(),
        dynamicControllers = [];

  void submit() {
    print('Title: ${titleController.text}');
    print('Mode: ${mode.name}');
    for (int i = 0; i < dynamicControllers.length; i++) {
      print('Dynamic Input $i: ${dynamicControllers[i].text}');
    }
  }

  void addDynamicInput() {
    dynamicControllers.add(TextEditingController());
    notifyListeners();
  }

  void removeDynamicInput(TextEditingController controller) {
    dynamicControllers.remove(controller);
    controller.dispose();
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
    super.dispose();
  }
}
