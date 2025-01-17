import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/models/my_toast.dart';
import 'package:achivement_box/output/generated/icon_names.dart';
import 'package:achivement_box/pages/homePage/Bodies/HomeBody/provider/levelProvider.dart';
import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/db.dart';
import '../pages/EditPages/editHabitPage.dart';
import '../rootProvider/habitProvider.dart';
import 'tileWithCounter.dart';

class Habit extends TileWithCounter {
  static const width = 110;
  final bool isBadHabit;
  final int priority;
  final int hardness;
  final int categoryId;
  final int timeInMinutes;

  @override
  void openEditPage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return EditHabitsPage(habit: this);
    }));
  }

  @override
  void clicked() {
    totalTimes++;
    if (super.totalTimes == 1) {
      db.sql.habits.addToLog(super.id);
    } else {
      db.sql.habits.updateLog(id: super.id, count: super.totalTimes);
    }
    if (isBadHabit) {
      context.read<CoinsProvider>().removeCoins(super.price);
    } else {
      context.read<CoinsProvider>().addCoins(super.price);
      context.read<LevelProvider>().xpIncreased();
      toastTitle = "habit done";
      undoToast.show(context);

      int newLevel = db.sql.categories.updateLevel(
          value: super.price + hardness + priority, id: categoryId);
      if (newLevel != 0) {
        MyToast(
          title: const Text("Level up"),
          animationType: AnimationType.fromBottom,
          toastPosition: Position.bottom,
          iconWidget: IconImage(
            iconName:
                iconNames[db.sql.categories.getById(categoryId)['IconId']],
          ),
          displayCloseButton: true,
        ).show(context);
      }
    }
    context.read<HabitProvider>().habitUpdated();
  }

  @override
  void undo() {
    if (super.totalTimes == 1) {
      db.sql.habits.deleteFromLog(super.id);
      super.totalTimes -= 1;
    } else {
      db.sql.habits.updateLog(id: id, count: --super.totalTimes);
    }

    context.read<HabitProvider>().habitUpdated();
    if (isBadHabit) {
      context.read<CoinsProvider>().addCoins(super.price);
    } else {
      context.read<CoinsProvider>().removeCoins(super.price);
      context.read<LevelProvider>().xpIncreased();
      db.sql.categories.removeLevel(
          value: super.price + hardness + priority, id: categoryId);
    }
  }

  Habit({
    super.key,
    required super.id,
    required super.iconId,
    required super.name,
    required super.totalTimes,
    required super.price,
    required super.context,
    required super.isArchived,
    required this.categoryId,
    required this.isBadHabit,
    required this.priority,
    required this.hardness,
    required this.timeInMinutes,
  });
  static Widget habitBuilder(context, habit) {
    return Habit(
      context: context,
      categoryId: habit['Category'],
      id: habit['Id'],
      totalTimes: habit['count'] ?? 0,
      hardness: habit['Hardness'],
      iconId: habit['IconId'],
      isArchived: habit['IsArchived'] == 1 ? true : false,
      isBadHabit: habit['IsBad'] == 1 ? true : false,
      name: habit['Name'],
      price: habit['Price'],
      priority: habit['Priority'],
      timeInMinutes: habit['TimeInMinutes'],
    );
  }
}
