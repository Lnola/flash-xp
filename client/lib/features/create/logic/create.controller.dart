import 'package:flutter/material.dart';

class CreateController extends ChangeNotifier {
  final TextEditingController titleController;

  CreateController() : titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}
