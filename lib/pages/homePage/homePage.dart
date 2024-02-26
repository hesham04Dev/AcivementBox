import "package:flutter/material.dart";

import "../../models/habit.dart";

class HomePage extends StatelessWidget {
  const HomePage() : super();
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
    return Scaffold(
        body: /*GridView(
        gridDelegate:
            SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 20),
        children: [
          h1,
        ],
      ),*/
            Column(
      children: [h1],
    ));
  }
}
