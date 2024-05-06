import 'package:flutter/material.dart';

import '../db/sql.dart';

class HabitProvider with ChangeNotifier {
  HabitProvider() {
    _Habits = getHabits();
  }
  newHabit() {
    _Habits = getHabits();
    notifyListeners();
  }

  habitUpdated() {
    _Habits = getHabits();
    notifyListeners();
  }

  var _Habits;
  get Habits => _Habits;
}
