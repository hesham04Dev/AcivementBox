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
    double totalHeight;
    double totalWidth;
    double filledHeight;
    double filledWidth;
    EdgeInsetsGeometry? margin;

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
      if (percent < 0.1) {
        margin = EdgeInsets.only(
            left: thickness * 0.1, top: totalHeight - filledHeight - 3);
        filledWidth -= thickness * 0.2;
      } else {
        margin = EdgeInsets.only(top: totalHeight - filledHeight);
      }
    } else {
      totalHeight = thickness;
      totalWidth = size;
      filledHeight = thickness;
      filledWidth = size * percent;
      if (percent < 0.1) {
        margin = EdgeInsets.only(top: thickness * 0.1, left: 2);
        filledHeight -= thickness * 0.2;
      } else
        margin = EdgeInsets.only();
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
          child: isVertical
              ? /*Transform.rotate(
                  angle: -3.14 / 2,
                  origin: Offset(totalWidth / 2 - 12, totalHeight / 2 - 10),
                  child: textWidget)*/
              FittedBox(child: textWidget)
              : FittedBox(child: textWidget),
        )
      ],
    );
  }
}
