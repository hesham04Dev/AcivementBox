import 'package:flutter/material.dart';

import '../../../models/Coins.dart';
import '../../../models/PrimaryContainer.dart';
import '../../../models/habit.dart';
import '../../../models/levelBar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Habit h1 = new Habit(
      categories: ["none"],
      hardness: 1,
      icon: Icons.sports_baseball,
      isBadHabit: false,
      name: " some long text pla pla",
      price: 10,
      priority: 5,
    );
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LevelBar(),
              CoinsBar(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("something changed every time"),
        ),
        Expanded(
          child: PrimaryContainer(
            opacity: 0.1,
            child: GridView.builder(
                itemBuilder: (context, index) => h1,
                itemCount: 30,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 121,
                    mainAxisExtent: 150,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 8)),
          ),
        ),
      ],
    );
  }
}
