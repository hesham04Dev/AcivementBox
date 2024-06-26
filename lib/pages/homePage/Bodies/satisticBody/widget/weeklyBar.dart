import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:flutter/material.dart';

import '../../../../../db/sql.dart';
import '../../../../../models/chartBar.dart';

class WeeklyBar extends StatelessWidget {
  WeeklyBar({super.key});

  //final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> x = getWeeklyData();
    if (x.length > 0) {
      int maxValue = 0;
      for (int i = 0; i < x.length; i++) {
        if (x[i]['Total'] > maxValue) {
          maxValue = x[i]['Total'];
        }
      }

      return PrimaryContainer(
        opacity: 0.1,
        child: Column(
          children: [
            Text("Coins bar"),
            SizedBox(
              height: 161,
              child: ListView(
                  // physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: List.generate(
                    x.length,
                    (index) {
                      String date = x[index]["DateOnly"];
                      date = date.replaceFirst("-", " ");
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 20,
                          child: Column(children: [
                            ChartBar(
                              percent: x[index]['Total'] / maxValue,
                              text: x[index]['Total'].toString(),
                              thickness: 25,
                              size: 120,
                              isVertical: true,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ConstrainedBox(
                                constraints:
                                    BoxConstraints(minHeight: 1, minWidth: 1),
                                child: Text(
                                  date,
                                  style: TextStyle(fontSize: 7.2),
                                )),
                          ]),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      );
    } else
      return PrimaryContainer(
        height: 150,
        child: Center(
          child: Text("do some habits to gather statistics on."),
        ),
      );
  }
}
