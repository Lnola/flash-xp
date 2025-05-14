import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  var title = "Home";
  var showBackButton = false;
  var tabIndex = 0;

  void setTitle(String newTitle) {
    title = newTitle;
    setShowBackButton(false);
    notifyListeners();
  }

  void setShowBackButton(bool show) {
    showBackButton = show;
    notifyListeners();
  }

  void setTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
