import 'package:achivement_box/db/sql.dart';
import 'package:flutter/material.dart';

import '../output/generated/colors.dart';

class IconImage extends StatelessWidget {
  final String iconName;
  final double size;
  Color? color;
  IconImage({required this.iconName, this.size = 25, this.color});
  @override
  Widget build(BuildContext context) {
    color ??= colors[getAccentColor()].withOpacity(0.8);
    return Image.asset(
      "assets/icons/$iconName",
      height: size,
      width: size,
      color: color,
    );
  }
}
