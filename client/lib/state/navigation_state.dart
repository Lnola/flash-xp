import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  var title = "Home";

  void setTitle(String title) {
    title = title;
    notifyListeners();
  }
}
