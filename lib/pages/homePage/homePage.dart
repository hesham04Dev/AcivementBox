import "package:achivement_box/models/MyBottomNavBar.dart";
import "package:achivement_box/pages/newHabit.dart";
import "package:flutter/material.dart";

import "../../models/Coins.dart";
import "../../models/habit.dart";
import "../../models/levelBar.dart";

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
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Column(
            children: [
              Text(
                "Achievement Box",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
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
              Expanded(
                child: GridView.builder(
                    itemBuilder: (context, index) => h1,
                    itemCount: 30,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 121,
                            mainAxisExtent: 130,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 8)),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const NewHabitPage();
              }));
            },
            child: const Icon(
              Icons.add_rounded,
              size: 25,
              color: Colors.white54,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MyBottomNavBar());
  }
}
