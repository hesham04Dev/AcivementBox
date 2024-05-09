import 'package:achivement_box/models/imageIcon.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../output/generated/icon_names.dart';

abstract class TileWithCounter extends StatefulWidget {
  TileWithCounter(
      {super.key,
      required this.id,
      required this.iconId,
      required this.name,
      required this.price,
      required this.context,
      required this.totalTimes}) {
    //clicked;
  }

  void openEditPage();

  void clicked();

  final int iconId;
  final String name;
  final int price;
  final BuildContext context;
  final int id;
  int totalTimes;
  @override
  State<TileWithCounter> createState() => _TileWithCounterState();
}

class _TileWithCounterState extends State<TileWithCounter> {
  void used() {
    widget.totalTimes++;
    widget.clicked();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 2, end: 2),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: Theme.of(context).primaryColor.withOpacity(0.6),
        elevation: 0,
      ),
      badgeContent: SizedBox(
          width: 20,
          height: 20,
          child: FittedBox(
              child: Text(
            "${widget.totalTimes}",
            textAlign: TextAlign.center,
          ))),
      child: GestureDetector(
        onLongPress: () => widget.openEditPage(),
        onTap: used,
        child: Container(
          width: 100,
          height: 140,
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              IconImage(
                iconName: iconNames[widget.iconId],
                size: 50,
              ),
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconImage(
                    iconName: "coin-front.png",
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("${widget.price}"),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 0),
                child: GestureDetector(
                  child: IconImage(iconName: "ellipsis-stroke.png", size: 20),
                  onTap: () {
                    widget.openEditPage();
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
