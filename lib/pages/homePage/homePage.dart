import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../models/imageIcon.dart";
import "../../rootProvider/bottomNavBarProvider.dart";
import "../AddNewPages/newGift.dart";
import "../AddNewPages/newHabit.dart";
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
  PageController bodiesController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    Widget FAB;
    if (pageIndex == 0 || pageIndex == 3) {
      FAB = SizedBox();
    } else {
      FAB = FloatingActionButton(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return pageIndex != 2 ? NewHabitPage() : const NewGiftPage();
            }));
          },
          child: const Icon(
            Icons.add_rounded,
            size: 25,
            color: Colors.white54,
          ));
    }

    List<Widget> bodies = [
      const SettingBody(),
      const HomeBody(),
      const GiftsBody(),
      const StatisticsBody()
    ];
    int color = context.watch<ColorProvider>().changeColor;
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text(
            "Achievement Box",
          ),
        ),
        body: PageView(
          /*child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: bodies[pageIndex],
          ),*/
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          controller: bodiesController,
          /*child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: bodies[pageIndex],
          ),*/
          children: bodies,
        ),
        floatingActionButton: FAB,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          iconSize: 25,
          onTap: (value) {
            setState(() {
              bodiesController.jumpToPage(value);
              pageIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: IconImage(
                  iconName: "gear.png",
                ),
                label: "settings"),
            BottomNavigationBarItem(
                icon: IconImage(
                  iconName: "igloo.png",
                ),
                label: "home"),
            BottomNavigationBarItem(
                icon: IconImage(
                  iconName: "gift.png",
                ),
                label: "gifts"),
            BottomNavigationBarItem(
                icon: IconImage(iconName: "chart-simple.png"),
                label: "statistics"),
          ],
        ));
  }
}
