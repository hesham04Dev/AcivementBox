/*import 'package:achivement_box/pages/satisticBody/statisticBody.dart';
import 'package:achivement_box/pages/setting/settingPage.dart';
import 'package:flutter/material.dart';

import '../pages/giftsPage/giftsPage.dart';
import 'imageIcon.dart';

class MyBottomNavBar extends StatefulWidget {
  MyBottomNavBar({super.key});
  int page = 1;
  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      elevation: 0,
      currentIndex: widget.page,
      iconSize: 25,
      onTap: (value) {
        setState(() {
          if (value == 0)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingBody()));
          else if (value == 2)
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => GiftsBody()));
          else if (value == 3)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StatisticsBody()));
          widget.page = value;
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
        /* BottomNavigationBarItem(
            icon: IconImage(
              path: "assets/icons/plus.png",
            ),
            label: "new"),*/
        BottomNavigationBarItem(
            icon: IconImage(
              path: "assets/icons/gift.png",
            ),
            label: "gifts"),
        BottomNavigationBarItem(
            icon: IconImage(path: "assets/icons/chart-simple.png"),
            label: "statistics"),
      ],
    );
  }
}
*/
