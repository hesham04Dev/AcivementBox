import 'package:achivement_box/models/TileShape.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(
      {super.key,
      required this.title,
      this.leading,
      this.trailing,
      required this.onTap,
      this.subtitle});
  final String title;
  final Widget? trailing;
  final Widget? leading;
  final String? subtitle;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        shape: tileShape,
        title: Text("$title"),
        trailing: trailing,
        subtitle: subtitle != null ? Text(subtitle!) : null,
        leading: leading,
        onTap: onTap,
      ),
    );
  }
}
