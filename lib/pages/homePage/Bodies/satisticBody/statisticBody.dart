import 'package:flutter/material.dart';

import '../../../../models/PrimaryContainer.dart';
import 'widget/categoriesLevel.dart';
import 'widget/weeklyBar.dart';

class StatisticsBody extends StatelessWidget {
  const StatisticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          WeeklyBar(),
          CategoriesLevel(),
          PrimaryContainer(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("total days: 10"),
              Icon(Icons.local_fire_department)
            ],
          )),
          PrimaryContainer(
            child: Row(
              children: [
                Text("top habit: "),
                Text("habit name"),
              ],
            ),
          ),
          PrimaryContainer(
            child: Row(
              children: [
                Text("top gift: "),
                Text("habit name"),
              ],
            ),
          ),
          PrimaryContainer(
            child: Row(
              children: [
                Text("top day: "),
                Text("no of coins"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
