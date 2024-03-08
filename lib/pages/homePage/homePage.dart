import "package:flutter/material.dart";

import "../../models/imageIcon.dart";
import "../giftsBody/giftsPage.dart";
import "../newHabit.dart";
import "../satisticBody/statisticBody.dart";
import "../settingBody/settingPage.dart";
import "widget/homeBody.dart";

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    const List<Widget> bodies = [
      SettingBody(),
      HomeBody(),
      GiftsBody(),
      StatisticsBody()
    ];
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
          child: bodies[pageIndex],
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          elevation: 0,
          currentIndex: pageIndex,
          iconSize: 25,
          onTap: (value) {
            setState(() {
              /*if (value == 0)
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingBody()));
              else if (value == 2)
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GiftsBody()));
              else if (value == 3)
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatisticsBody()));*/
              pageIndex = value;
            });
          },
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.lightGreen,
          items: [
            BottomNavigationBarItem(
                icon: IconImage(
                  path: "assets/icons/gear.png",
                ),
                label: "settings"),
            BottomNavigationBarItem(
                icon: IconImage(
                  path: "assets/icons/igoo.png",
                ),
                label: "home"),
            BottomNavigationBarItem(
                icon: IconImage(
                  path: "assets/icons/gift.png",
                ),
                label: "gifts"),
            BottomNavigationBarItem(
                icon: IconImage(path: "assets/icons/chart-simple.png"),
                label: "statistics"),
          ],
        ));
  }
}
