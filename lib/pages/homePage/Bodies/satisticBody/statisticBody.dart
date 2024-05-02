import 'package:achivement_box/db.dart';
import 'package:achivement_box/pages/homePage/Bodies/satisticBody/widget/statisticBar.dart';
import 'package:flutter/material.dart';

import 'widget/categoriesLevel.dart';
import 'widget/weeklyBar.dart';

class StatisticsBody extends StatelessWidget {
  const StatisticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    //final totalDays = getTotalDays();
    final topHabit = getTopHabit();
    final topGift = getTopGift();
    final topDay = getTopDay();
    return Scaffold(
      body: ListView(
        children: [
          WeeklyBar(),
          CategoriesLevel(),
          const StatisticBar(statisticName: "Total Days", valueName: "0"),
          StatisticBar(
            statisticName: "Top Habit",
            valueName: "${topHabit[0]['Name']}",
            icon: Text("${topHabit[0]['Total']} Times"),
          ),
          StatisticBar(
            statisticName: "Top Gift",
            valueName: "${topGift[0]['Name']}",
            icon: Text("${topGift[0]['Total']} Times"),
          ),
          StatisticBar(
              statisticName: "Top Day", valueName: "${topDay[0]['Total']}"),
        ],
      ),
    );
  }
}
