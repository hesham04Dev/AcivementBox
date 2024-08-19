import 'package:flutter/material.dart';

import '../db/db.dart';

class HabitProvider with ChangeNotifier {
  HabitProvider() {
    _Habits = db.sql.habits.get();
  }
  newHabit() {
    _Habits = db.sql.habits.get();
    notifyListeners();
  }

  habitUpdated() {
    _Habits = db.sql.habits.get();
    notifyListeners();
  }

  var _Habits;
  get Habits => _Habits;
}
