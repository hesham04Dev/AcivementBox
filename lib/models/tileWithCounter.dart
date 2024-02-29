import 'package:achivement_box/models/imageIcon.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

abstract class TileWithCounter extends StatefulWidget {
  TileWithCounter(
      {super.key,
      required this.icon,
      required this.name,
      required this.price}) {
    openEditPage();
    clicked();
  }

  void openEditPage();

  void clicked();

  final IconData? icon;
  final String name;
  final num price;

  @override
  State<TileWithCounter> createState() => _TileWithCounterState();
}

class _TileWithCounterState extends State<TileWithCounter> {
  int totalTimes = 0;

  void used() {
    totalTimes++;
    widget.clicked;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 2, end: 2),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.twitter,
        badgeColor: Colors.lightGreen.withOpacity(0.6),
        elevation: 0,
      ),
      badgeContent: SizedBox(
          width: 20,
          height: 20,
          child: FittedBox(
              child: Text(
            "$totalTimes",
            textAlign: TextAlign.center,
          ))),
      child: GestureDetector(
        onLongPress: widget.openEditPage,
        onTap: used,
        child: Container(
          width: 100,
          height: 120,
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.lightGreen[200],
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  child: Icon(
                widget.icon,
                size: 50,
              )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(widget.name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0),
                child: GestureDetector(
                  child: IconImage(
                      path: "assets/icons/ellipsis-stroke.png", size: 20),
                  onTap: () {
                    widget.openEditPage;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
