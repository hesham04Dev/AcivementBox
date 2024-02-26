import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      position: badges.BadgePosition.topEnd(top: 0, end: 0),
      badgeAnimation: const badges.BadgeAnimation.fade(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.twitter,
        badgeColor: Colors.blue,
        padding: const EdgeInsets.all(5),
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.white, width: 2),
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
            color: Colors.red,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /* Row(
                  mainAxisSize: MainAxisSize.max,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [*/
              const SizedBox(
                height: 10,
              ),
              Container(
                  child: Icon(
                widget.icon,
                size: 50,
              )),
              /*Container(
                      margin: EdgeInsets.only(top: 0),
                      child: IconButton(
                        icon: Text("$totalTimes"),
                        iconSize: 10,
                        onPressed: used,
                      ),
                    ),*/
              /* ]),*/
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(widget.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    //textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0),
                child: GestureDetector(
                  //constraints: BoxConstraints(maxHeight: 20),

                  child: const Icon(
                    // opticalSize: 5,
                    size: 20,
                    FontAwesomeIcons.ellipsis,
                  ),
                  //iconSize: 20,
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
