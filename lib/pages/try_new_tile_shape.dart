import 'package:flutter/material.dart';

import '../models/habit.dart';

class NewShape extends StatelessWidget {
  const NewShape({super.key});

  @override
  Widget build(BuildContext context) {
    Habit habit = Habit(
        id: 0,
        iconId: 0,
        name: "qwerty uiop asdfg hjkl; m",
        totalTimes: 2,
        price: 10,
        context: context,
        categoryId: 1,
        isBadHabit: false,
        priority: 5,
        hardness: 5,
        timeInMinutes: 10);
    return Scaffold(
      body: Center(
        child: habit,
      ),
    );
  }
}
