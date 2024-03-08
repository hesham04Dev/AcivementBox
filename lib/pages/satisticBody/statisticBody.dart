import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:achivement_box/pages/satisticBody/widget/categoriesLevel.dart';
import 'package:achivement_box/pages/satisticBody/widget/weeklyBar.dart';
import 'package:flutter/material.dart';

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
