import 'package:flutter/material.dart';

import '../../../db.dart';

class HabitProvider with ChangeNotifier {
  HabitProvider() {
    _Habits = getHabits();
  }
  newHabit() {
    _Habits = getHabits();
    notifyListeners();
  }

  var _Habits;
  get Habits => _Habits;
}
