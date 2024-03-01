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
          widget.page = value;
        });
      },
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.lightGreen,
      items: [
        /* TODO make the taped one like this
    BottomNavigationBarItem(
        icon: Container(
          width: 70,
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 2,
              ),
              IconImage(
                path: "assets/icons/gear.png",
                size: 11,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "settings",
                style: TextStyle(fontSize: 11),
              )
            ],
          ),
        ),
        label: "dd"),*/
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
