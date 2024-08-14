import 'package:flutter/material.dart';

import '../models/habit.dart';

class NewShape extends StatelessWidget {
  const NewShape({super.key});

  @override
  Widget build(BuildContext context) {
    int crossCount = ((MediaQuery.sizeOf(context).width - 40) / 110).floor();
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
      body: GridView.builder(
          itemBuilder: (context, index) => Habit(
              context: context,
              categoryId: habit.categoryId,
              id: habit.id,
              totalTimes: 0,
              hardness: 1,
              iconId: 1,
              isBadHabit: 0 == 1 ? true : false,
              name: habit.name,
              price: habit.price,
              priority: 5,
              timeInMinutes: 5),
          itemCount: 20,
          shrinkWrap: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossCount, childAspectRatio: 110 / 150)),
    );
  }
}
