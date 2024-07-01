import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';

class IconImage extends StatelessWidget {
  final String iconName;
  final double size;
  Color? color;
  IconImage({super.key, required this.iconName, this.size = 25, this.color});
  @override
  Widget build(BuildContext context) {
    color ??= DynamicColorTheme.of(context).color.withOpacity(0.8);
    return Image.asset(
      "assets/icons/$iconName",
      height: size,
      width: size,
      color: color,
    );
  }
}
