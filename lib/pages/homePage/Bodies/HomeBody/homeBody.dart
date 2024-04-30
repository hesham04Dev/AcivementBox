import 'dart:math';

import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/pages/homePage/Bodies/HomeBody/provider/levelProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/Coins.dart';
import '../../../../models/PrimaryContainer.dart';
import '../../../../models/habit.dart';
import '../../../../models/levelBar.dart';
import '../../../../rootProvider/habitProvider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
  final List<String> somethingChangedEveryTime = const [
    "hello ",
    "any thing",
    "pla",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    '10',
    "11",
    "12",
    "13",
  ];
  @override
  Widget build(BuildContext context) {
    //var habits = getHabits();

    //print(habits[1]);
    var habits = context.watch<HabitProvider>().Habits;
    return ChangeNotifierProvider(
      create: (context) => LevelProvider(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LevelBar(
                  canChange: true,
                ),
                const CoinsBar(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(somethingChangedEveryTime[
                Random().nextInt(somethingChangedEveryTime.length - 1)]),
          ),
          Expanded(
            child: PrimaryContainer(
              opacity: 0.1,
              child: GridView.builder(
                  itemBuilder: (context, index) => Habit(
                        context: context,
                        categoryId: habits[index]['Category'],
                        id: habits[index]['Id'],
                        totalTimes: habits[index]['count'] ?? 0,
                        hardness: habits[index]['Hardness'],
                        icon: IconImage(
                          path: "assets/icons/gear.png",
                          size: 50,
                        ) /*IdToIcon(id:habits[index]['Icon'])*/,
                        isBadHabit: habits[index]['IsBad'] == 1 ? true : false,
                        name: habits[index]['Name'],
                        price: habits[index]['Price'],
                        priority: habits[index]['Priority'],
                      ),
                  itemCount: habits.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 121,
                      mainAxisExtent: 150,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 8)),
            ),
          ),
        ],
      ),
    );
  }
}
/*TODO
*  save the coins in the db  --done--
* use chatgpt to generate some sentence to show in somethingChangedEveryTime
* make edit habit page
* solve the problem of new habit page --done--
* new category page and edit category are desplayed in tstatistic page and on
* new habit --done--
* add move to archive for the habit
* create archive page note remove from archive can be done but it will remove all the log and decrease the coins
*
* */
