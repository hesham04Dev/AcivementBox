import 'package:achivement_box/models/TileShape.dart';
import 'package:flutter/material.dart';

class MySwitchTile extends StatefulWidget {
  MySwitchTile({super.key, required this.title});

  @override
  State<MySwitchTile> createState() => _MySwitchTileState();
  bool value = false;
  final String title;
}

class _MySwitchTileState extends State<MySwitchTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(widget.title),
        shape: tileShape,
        value: widget.value,
        onChanged: (value) {
          widget.value = value;
          setState(() {});
        });
  }
}
