import "package:achivement_box/models/PrimaryContainer.dart";
import "package:flutter/material.dart";

import "../../models/Coins.dart";
import "../../models/habit.dart";
import "../../models/levelBar.dart";

class GiftsBody extends StatelessWidget {
  const GiftsBody() : super();

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
        Text("recent"),
        PrimaryContainer(
          opacity: 0.1,
          height: 150,
          child: ListView.builder(
              itemBuilder: (context, index) => h1,
              itemCount: 10, //max is 10
              scrollDirection: Axis.horizontal),
        ),
        //TODO if null dont show any
        Text("all items"),
        Expanded(
          child: PrimaryContainer(
            opacity: 0.1,
            child: GridView.builder(
                itemBuilder: (context, index) => h1,
                itemCount: 30,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 121,
                    mainAxisExtent: 130,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 8)),
          ),
        ),
      ],
    );
  }
}
