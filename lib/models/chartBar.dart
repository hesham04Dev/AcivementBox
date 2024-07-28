import 'package:achivement_box/db/sql.dart';
import 'package:flutter/material.dart';

import '../output/generated/colors.dart';

class ChartBar extends StatelessWidget {
  final String text;
  final double size;
  final double percent;
  final double thickness;
  final bool isVertical;
  const ChartBar(
      {super.key,
      required this.text,
      this.size = 110,
      required this.percent,
      this.thickness = 15,
      this.isVertical = false});

  @override
  Widget build(BuildContext context) {
    double percent = this.percent;
    double totalHeight;
    double totalWidth;
    double filledHeight;
    double filledWidth;
    EdgeInsetsGeometry? margin;
    if (percent < 0.1 && percent > 0) {
      percent = 0.1;
    }
    var textWidget = Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 12),
    );
    if (isVertical) {
      totalWidth = thickness;
      totalHeight = size;
      filledHeight = size * percent;
      filledWidth = thickness;
      margin = EdgeInsets.only(top: totalHeight - filledHeight);
    } else {
      totalHeight = thickness;
      totalWidth = size;
      filledHeight = thickness;
      filledWidth = size * percent;
      margin = const EdgeInsets.only();
    }
    return Stack(
      children: <Widget>[
        Container(
          height: totalHeight,
          width: totalWidth,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey.shade100, width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Container(
          margin: margin,
          height: filledHeight,
          width: filledWidth,
          decoration: BoxDecoration(
              color: colors[getAccentColorIndex()],
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          width: size,
          height: thickness,
          child: FittedBox(child: textWidget),
        )
      ],
    );
  }
}
