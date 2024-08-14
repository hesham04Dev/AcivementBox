import 'package:achivement_box/models/habitGiftTabPage.dart';
import 'package:achivement_box/models/my_grid_view.dart';
import 'package:flutter/material.dart';

import '../../db/sql.dart';
import '../../models/gift.dart';
import '../../models/habit.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    var habits = getArchivedHabits();
    var gifts = getArchivedGifts();
    StatelessWidget habitsData;
    StatelessWidget giftsData;
    if (isListView()) {
      habitsData = ListView.builder(
        itemBuilder: (context, index) {
          return Habit.habitBuilder(context, habits[index]);
        },
        itemCount: habits.length,
      );
      giftsData = ListView.builder(
          itemBuilder: (context, index) {
            return Gift.giftBuilder(context, gifts[index]);
          },
          itemCount: gifts.length);
    } else {
      habitsData = MyGridView(
          itemBuilder: (context, index) {
            return Habit.habitBuilder(context, habits[index]);
          },
          itemCount: habits.length);
      giftsData = MyGridView(
          itemBuilder: (context, index) {
            return Gift.giftBuilder(context, gifts[index]);
          },
          itemCount: gifts.length);
    }
    return HabitGiftTabPage(
        tabBarView: TabBarView(
      children: [habitsData, giftsData],
    ));
  }
}
