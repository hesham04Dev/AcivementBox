import "package:achivement_box/models/Coins.dart";
import "package:achivement_box/models/levelBar.dart";
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            //backgroundColor: Colors.cyan,
            title: Column(
              children: [
                Text(
                  "Achivement Box",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: 110,
                        child: VerticalChartBar(value: 1, percent: 0.2)),
                    CoinsBar(),
                  ],
                ),
              ],
            ),
            elevation: 0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
              itemBuilder: (context, index) => h1,
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 121,
                  mainAxisExtent: 130,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8)),
        ));
  }
}
