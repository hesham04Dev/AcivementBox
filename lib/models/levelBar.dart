import 'package:flutter/material.dart';

class LevelBar extends StatelessWidget {
  final double percent = 0.1;
  final int level = 2;
  final int maxXp = 200;
  final int currentXp = 40;

  const LevelBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return SizedBox(
          width: 110,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(/*"level: $level"*/ "$currentXp / $maxXp",
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              //height: constraints.maxHeight,
              height: 15,
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
                  SizedBox(
                    width: constraints.maxWidth,
                    child: FittedBox(
                      child: Text(
                        "level: $level",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
