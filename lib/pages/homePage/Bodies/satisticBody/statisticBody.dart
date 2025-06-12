
import 'package:flutter/material.dart';
import "package:localization_lite/translate.dart";


import '../../../../db/db.dart';
import '../../../../models/imageIcon.dart';
import '../../../../pages/homePage/Bodies/satisticBody/widget/statisticBar.dart';

import 'widget/categoriesLevel.dart';
import 'widget/weeklyBar.dart';

class StatisticsBody extends StatelessWidget {
  const StatisticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final topHabit = db.sql.habits.getTop();
    final topGift = db.sql.gifts.getTop();
    final topDay = db.sql.habits.getTopDay();
    final streak = db.sql.settings.getStreak();

    return Scaffold(
      body: ListView(
        children: [
          const WeeklyBar(),
          const CategoriesLevel(),
          StatisticBar(
            statisticName: tr("streak"),
            valueName: "$streak",
            icon: IconImage(
              iconName: 'fire-flame.png',
            ),
          ),
          topHabit.isNotEmpty
              ? StatisticBar(
                  statisticName: tr("topHabit"),
                  valueName: "${topHabit[0]?['Name']}",
                  icon: Text("${topHabit[0]?['Total']} ${tr("times")}"),
                )
              : const SizedBox(),
          topGift.isNotEmpty
              ? StatisticBar(
                  statisticName: "Top Gift",
                  valueName: "${topGift[0]['Name']}",
                  icon: Text("${topGift[0]['Total']} ${tr("times")}"),
                )
              : const SizedBox(),
          topDay.isNotEmpty
              ? StatisticBar(
                  statisticName: tr("topDay"),
                  valueName: "${topDay[0]['DateOnly']}",
                  icon: Text("${topDay[0]['Total']} ${tr("coins")}"),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
