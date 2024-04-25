import 'package:achivement_box/db.dart';
import 'package:achivement_box/pages/homePage/Bodies/HomeBody/provider/levelProvider.dart';
import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:achivement_box/pages/newHabit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tileWithCounter.dart';

class Habit extends TileWithCounter {
  final bool isBadHabit;
  final int priority;
  final int hardness;
  final List<String> categories;

  void openEditPage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return NewHabitPage();
    }));
  }

  void clicked() {
    if (isBadHabit) {
      //TODO remove price from the coins
      context.read<CoinsProvider>().removeCoins(super.price);
    }
    context.read<CoinsProvider>().addCoins(super.price);
    context.read<LevelProvider>().xpIncreased();
    updateLevel(value: super.price + hardness + priority);

    // base level add  priority * 2 + hardness
    // the same for the category level but is devided for the number of the categories in
    //show a toast with the exp gained
    //TODO provide this to the coins by provider
  }

  Habit(
      {required super.icon,
      required super.name,
      required super.price,
      required super.context,
      required this.categories,
      required this.isBadHabit,
      required this.priority,
      required this.hardness});
}
