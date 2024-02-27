import 'package:flutter/material.dart';

class VerticalChartBar extends StatelessWidget {
  final int value;
  final double percent;

  const VerticalChartBar(
      {required this.value, required this.percent, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text("level: 2",
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            //height: constraints.maxHeight,
            height: 11,
            width: constraints.maxWidth,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey, width: 1.0),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percent,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }
}
