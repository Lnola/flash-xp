import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  var title = "Home";
  var tabIndex = 0;

  void setTitle(String title) {
    title = title;
    notifyListeners();
  }

  void setTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
