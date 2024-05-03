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
  //TODO err in provider here since i dont need to make the icon updated in new habit when i update the icon of new category
  //TODO also i need the + icon to be shown when the page opened
}
