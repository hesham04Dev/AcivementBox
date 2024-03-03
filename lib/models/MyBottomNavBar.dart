import 'package:achivement_box/pages/setting/settingPage.dart';
import 'package:flutter/material.dart';

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
                MaterialPageRoute(builder: (context) => SettingPage()));
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
              path: "assets/icons/house-blank.png",
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
