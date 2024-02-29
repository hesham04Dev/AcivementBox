import 'package:flutter/material.dart';

class IconImage extends StatelessWidget {
  final String path;
  final double size;
  Color? color;
  IconImage({required this.path, this.size = 25, this.color});
  @override
  Widget build(BuildContext context) {
    color ??= Theme.of(context).primaryColor;
    return Image.asset(
      path,
      height: size,
      width: size,
      color: color,
    );
  }
}
