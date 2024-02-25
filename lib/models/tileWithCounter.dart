import 'package:flutter/material.dart';

abstract class TileWithCounter extends StatefulWidget {
  TileWithCounter(
      {super.key,
      required this.icon,
      required this.name,
      /*required this.openEditPage,
      required this.clicked,*/
      required this.price}) {
    openEditPage();
    clicked();
  }
  void openEditPage();
  void clicked();
  final IconData? icon;
  final String name;
  /*final Function openEditPage;
  final Function clicked;*/
  final num price;

  @override
  State<TileWithCounter> createState() => _TileWithCounterState();
}

class _TileWithCounterState extends State<TileWithCounter> {
  _TileWithCounterState() {}
  int totalTimes = 0;

  void used() {
    totalTimes++;
    widget.clicked(widget.price);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.openEditPage(),
      onTap: used,
      child: Container(
        child: Column(
          children: [
            Row(children: [
              IconButton(
                icon: Text("$totalTimes"),
                onPressed: used,
              ),
              Container(
                  child: Icon(
                widget.icon,
                size: 50,
              )),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  widget.openEditPage();
                },
              ),
            ]),
            Text(widget.name),
          ],
        ),
      ),
    );
  }
}
