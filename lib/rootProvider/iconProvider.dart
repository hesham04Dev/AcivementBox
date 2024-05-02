import 'package:achivement_box/output/generated/icon_names.dart';
import 'package:flutter/material.dart';

class IconProvider with ChangeNotifier {
  IconUpdated(int newIconId) {
    _IconName = iconNames[newIconId];
    _IconId = newIconId;
    notifyListeners();
  }

  int _IconId = 0;
  String _IconName = "plus.png";
  get IconName => _IconName;
  get IconId => _IconId;
}
