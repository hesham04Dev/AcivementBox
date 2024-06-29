import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:achivement_box/pages/homePage/Bodies/HomeBody/provider/levelProvider.dart';
import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/sql.dart';
import '../pages/EditPages/editHabitPage.dart';
import '../rootProvider/habitProvider.dart';
import 'tileWithCounter.dart';

class Habit extends TileWithCounter {
  final bool isBadHabit;
  final int priority;
  final int hardness;
  final int categoryId;
  final int timeInMinutes;

  void openEditPage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return EditHabitsPage(habit: this);
    }));
  }

  void clicked() {
    if (super.totalTimes == 1) {
      db.execute('''
      insert into logHabit values('$formattedDate',${super.id},1)
      ''');
    } else {
      db.execute('''
      update  logHabit set
      count = ${super.totalTimes}
      where DateOnly = '$formattedDate'
      and HabitId =${super.id}
      ''');
    }
    if (isBadHabit) {
      context.read<CoinsProvider>().removeCoins(super.price);
    } else {
      context.read<CoinsProvider>().addCoins(super.price);
      context.read<LevelProvider>().xpIncreased();
      int? res =
          updateLevel(value: super.price + hardness + priority, id: categoryId);
      if (res != null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Dialog(
                    child: PrimaryContainer(
                      child: Text(
                        "level up",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            });
      }
    }
    context.read<HabitProvider>().habitUpdated();
  }

  Habit({
    required super.id,
    required super.iconId,
    required super.name,
    required super.totalTimes,
    required super.price,
    required super.context,
    required this.categoryId,
    required this.isBadHabit,
    required this.priority,
    required this.hardness,
    required this.timeInMinutes,
  });
}
