import 'package:flutter/material.dart';

class IconImage extends StatelessWidget {
  final String iconName;
  final double size;
  Color? color;
  IconImage({super.key, required this.iconName, this.size = 25, this.color});
  @override
  Widget build(BuildContext context) {
    color ??= Theme.of(context).primaryColor.withOpacity(0.8);
    return Image.asset(
      "assets/icons/$iconName",
      height: size,
      width: size,
      color: color,
    );
  }
}
