import 'package:flutter/material.dart';

class IconImage extends StatelessWidget {
  final String iconName;
  final double size;
  Color? color;
  IconImage({required this.iconName, this.size = 25, this.color});
  @override
  Widget build(BuildContext context) {
    color ??= Theme.of(context).primaryColor;
    return Image.asset(
      "assets/icons/$iconName",
      height: size,
      width: size,
      color: color,
    );
  }
}
