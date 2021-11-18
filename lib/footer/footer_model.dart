import 'package:flutter/material.dart';

class FooterModel extends ChangeNotifier {
  int currentIndex = 0;
  FooterModel() {}

  void changeSelectedItemColor() {
    if (currentIndex == 0) {
      currentIndex = 1;
    } else {
      currentIndex = 0;
    }
    notifyListeners();
  }
}
