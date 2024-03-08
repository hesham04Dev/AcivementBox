import 'package:flutter/material.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double opacity;
  final double padding;
  final double margin;
  const PrimaryContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.opacity = 0.2,
    this.padding = 8,
    this.margin = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor.withOpacity(opacity)),
      child: child,
    );
  }
}
