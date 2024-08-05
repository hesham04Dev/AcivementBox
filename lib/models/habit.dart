import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/models/my_toast.dart';
import 'package:achivement_box/output/generated/icon_names.dart';
import 'package:achivement_box/pages/homePage/Bodies/HomeBody/provider/levelProvider.dart';
import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/sql.dart';
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

  void openEditPage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return EditHabitsPage(habit: this);
    }));
  }

  @override
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
      toastTitle = "habit done";
      //super.showToast(context);
      undoToast.show(context);
      /*undoToast;
      undoOverlayController.show();*/
      //showOverlay(context);

      int? res =
          updateLevel(value: super.price + hardness + priority, id: categoryId);
      if (res != null) {
        MyToast(
          title: const Text("Level up"),
          animationType: AnimationType.fromBottom,
          toastPosition: Position.bottom,
          iconWidget: IconImage(
            iconName: iconNames[getCategory(categoryId)['IconId']],
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
      db.execute('''
      delete from logHabit where HabitId = ${super.id} and DateOnly = '$formattedDate'
      ''');
      super.totalTimes -= 1;
    } else {
      db.execute('''
      update  logHabit set
      count = ${--super.totalTimes}
      where DateOnly = '$formattedDate'
      and HabitId =${super.id}
      ''');
    }

    context.read<HabitProvider>().habitUpdated();
    if (isBadHabit) {
      context.read<CoinsProvider>().addCoins(super.price);
    } else {
      context.read<CoinsProvider>().removeCoins(super.price);
      context.read<LevelProvider>().xpIncreased();
      removeLevel(value: super.price + hardness + priority, id: categoryId);
    }
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
