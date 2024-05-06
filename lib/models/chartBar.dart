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
    } else {
      totalHeight = thickness;
      totalWidth = size;
      filledHeight = thickness;
      filledWidth = size * percent;
    }
    return Stack(
      children: <Widget>[
        Container(
          height: totalHeight,
          width: totalWidth,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: isVertical
              ? EdgeInsets.only(top: totalHeight - filledHeight)
              : null,
          height: filledHeight,
          width: filledWidth,
          decoration: BoxDecoration(
              color: colors[getAccentColor()],
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
