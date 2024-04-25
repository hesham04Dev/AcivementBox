import 'package:flutter/cupertino.dart';

import '../../../db.dart';

class HomePageProvider with ChangeNotifier {
  HomePageProvider() {
    _Habits = getHabits();
  }
  newItem() {
    _Habits = getHabits();
    notifyListeners();
  }

  var _Habits;
  get Habits => _Habits;
}
