import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  colorChanged() {
    _changeColor++;
    notifyListeners();
  }

  int _changeColor = 0;
  get changeColor => _changeColor;
}
