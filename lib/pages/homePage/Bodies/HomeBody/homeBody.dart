import 'dart:math';

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
    "Small daily habits lead to big achievements over time.",
    "Every step you take brings you closer to your goal.",
    "Consistency is the key to success; keep going!",
    "Believe in yourself and all that you are capable of.",
    "Celebrate every small victory; they add up to great success.",
    "Focus on progress, not perfection.",
    "Your only limit is your mind; think big!",
    "Commit to your goals, and they will become your reality.",
    "Stay motivated; your hard work will pay off.",
    "Embrace challenges; they are opportunities to grow.",
    "Stay disciplined, and success will follow.",
    "Every habit you build strengthens your path to achievement.",
    "Visualize your success and work towards it daily.",
    "Remember, the journey is as important as the destination.",
    "Push yourself; the results will be worth it.",
    "Keep your goals in sight and your determination strong.",
    "You have the power to create the life you want.",
    "Stay positive; a positive mindset fuels progress.",
    "Dedicate yourself to your goals, and they will be within reach.",
    "Your achievements are the sum of your daily actions; make each day count.",
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LevelBar(
                  canChange: true,
                ),
                CoinsBar(),
              ],
            ),
          ),
          Text(somethingChangedEveryTime[
              Random().nextInt(somethingChangedEveryTime.length - 1)]),
          Expanded(
            child: PrimaryContainer(
              opacity: 0.1,
              padding: 0,
              paddingHorizontal: 8,
              child: GridView.builder(
                  itemBuilder: (context, index) => Habit(
                        context: context,
                        categoryId: habits[index]['Category'],
                        id: habits[index]['Id'],
                        totalTimes: habits[index]['count'] ?? 0,
                        hardness: habits[index]['Hardness'],
                        iconId: habits[index]['IconId'],
                        isBadHabit: habits[index]['IsBad'] == 1 ? true : false,
                        name: habits[index]['Name'],
                        price: habits[index]['Price'],
                        priority: habits[index]['Priority'],
                        timeInMinutes: habits[index]['TimeInMinutes'],
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
