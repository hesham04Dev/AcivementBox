import 'package:flutter/material.dart';
import "package:localization_lite/translate.dart";


class HabitGiftTabPage extends StatelessWidget {
  final TabBarView tabBarView;
  final String title;
  const HabitGiftTabPage(
      {super.key, required this.tabBarView, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 5),
              child: TabBar(tabs: [Text(tr("habits")), Text(tr("gifts"))])),
        ),
        body: tabBarView,
      ),
    );
  }
}
