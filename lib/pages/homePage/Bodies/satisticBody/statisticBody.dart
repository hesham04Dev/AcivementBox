import 'package:achivement_box/pages/homePage/Bodies/satisticBody/widget/statisticBar.dart';
import 'package:flutter/material.dart';

import '../../../../db/sql.dart';
import '../../../../models/imageIcon.dart';
import 'widget/categoriesLevel.dart';
import 'widget/weeklyBar.dart';

class StatisticsBody extends StatelessWidget {
  const StatisticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final topHabit = getTopHabit();
    final topGift = getTopGift();
    final topDay = getTopDay();
    final streak = getStreak();

    return Scaffold(
      body: ListView(
        children: [
          const WeeklyBar(),
          const CategoriesLevel(),
          StatisticBar(
            statisticName: "Streak",
            valueName: "$streak",
            icon: IconImage(
              iconName: 'fire-flame.png',
            ),
          ),
          topHabit.length > 0
              ? StatisticBar(
                  statisticName: "Top Habit",
                  valueName: "${topHabit[0]?['Name']}",
                  icon: Text("${topHabit[0]?['Total']} Times"),
                )
              : const SizedBox(),
          topGift.length > 0
              ? StatisticBar(
                  statisticName: "Top Gift",
                  valueName: "${topGift[0]['Name']}",
                  icon: Text("${topGift[0]['Total']} Times"),
                )
              : const SizedBox(),
          topDay.length > 0
              ? StatisticBar(
                  statisticName: "Top Day",
                  valueName: "${topDay[0]['DateOnly']}",
                  icon: Text("${topDay[0]['Total']} Coins"),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
