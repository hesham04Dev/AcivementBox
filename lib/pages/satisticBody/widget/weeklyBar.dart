import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:flutter/material.dart';

import '../../../models/chartBar.dart';

class WeeklyBar extends StatelessWidget {
  const WeeklyBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: Column(
        children: [
          Text("Coins bar"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                7,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 20,
                        child: Column(children: [
                          ChartBar(
                            percent: 0.9,
                            text: "5",
                            thickness: 20,
                            size: 120,
                            isVertical: true,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(child: Text("mon"))
                        ]),
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
