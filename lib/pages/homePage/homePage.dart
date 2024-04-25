import "package:flutter/material.dart";

import "../../models/imageIcon.dart";
import "../newHabit.dart";
import "Bodies/HomeBody/homeBody.dart";
import "Bodies/giftsBody/giftsPage.dart";
import "Bodies/satisticBody/statisticBody.dart";
import "Bodies/settingBody/settingPage.dart";

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> bodies = [
      SettingBody(),
      HomeBody(),
      GiftsBody(),
      StatisticsBody()
    ];
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text(
            "Achievement Box",
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
                return NewHabitPage();
                //TODO return pageIndex != 2 ? NewHabitPage() : NewGiftPage;
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
