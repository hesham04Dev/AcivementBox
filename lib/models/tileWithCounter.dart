import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../db/db.dart';
import '../output/generated/icon_names.dart';
import 'PrimaryContainer.dart';
import 'imageIcon.dart';
import 'my_toast.dart';

abstract class TileWithCounter extends StatefulWidget {
  TileWithCounter(
      {super.key,
      required this.id,
      required this.iconId,
      required this.name,
      required this.price,
      required this.context,
      required this.totalTimes,
      required this.isArchived});

  void openEditPage();

  void clicked();

  late MyToast undoToast = MyToast(
    title: Text(toastTitle),
    button: TextButton(
      onPressed: () {
        undoToast.closeOverlay();
        undo();
      },
      child: const Text("undo"),
    ),
  );

  late String toastTitle;

  void undo();

  final int iconId;
  final String name;
  final int price;
  final BuildContext context;
  final int id;
  final bool isArchived;
  static const double width = 100;
  int totalTimes;

  @override
  State<TileWithCounter> createState() => _TileWithCounterVerticalState();
}

class _TileWithCounterVerticalState extends State<TileWithCounter> {
  void used() {
    widget.clicked();
    setState(() {});
  }

  Widget gridBuild() {
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
          ),
        ),
      ),
      child: GestureDetector(
        onLongPress: widget.openEditPage,
        onTap: used,
        child: PrimaryContainer(
          width: TileWithCounter.width,
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 10,
              ),
              IconImage(
                iconName: iconNames[widget.iconId],
                size: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                child: AutoSizeText(
                  widget.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 11,
                  maxFontSize: 14,
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
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${widget.price}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              GestureDetector(
                onTap: widget.openEditPage,
                child: IconImage(iconName: "ellipsis-stroke.png", size: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listBuild() {
    return GestureDetector(
      onLongPress: widget.openEditPage,
      child: PrimaryContainer(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            IconImage(
              iconName: iconNames[widget.iconId],
              size: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name),
                    Row(children: [
                      IconImage(
                        iconName: "coin-front.png",
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("${widget.price}"),
                    ])
                  ]),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            TextButton(onPressed: used, child: Text("${widget.totalTimes}"))
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return db.sql.settings.isListView() ? listBuild() : gridBuild();
  }
}
