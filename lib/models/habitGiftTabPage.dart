import 'package:flutter/material.dart';

class HabitGiftTabPage extends StatelessWidget {
  final TabBarView tabBarView;
  const HabitGiftTabPage({super.key, required this.tabBarView});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Archive"),
          bottom: const PreferredSize(
              preferredSize: Size(double.infinity, 5),
              child: TabBar(tabs: [Text("Habits"), Text("Gifts")])),
        ),
        body: tabBarView,
      ),
    );
  }
}
