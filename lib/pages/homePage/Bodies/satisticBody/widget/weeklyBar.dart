import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:achivement_box/models/styles.dart';
import 'package:flutter/material.dart';

import '../../../../../db/sql.dart';
import '../../../../../fn/money_labeling.dart';
import '../../../../../models/verticalBar.dart';

class WeeklyBar extends StatelessWidget {
  const WeeklyBar({super.key});

  //final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> x = getWeeklyData();
    if (x.isNotEmpty) {
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
            Text(
              "Coins bar",
              style: titleStyle(context),
            ),
            SizedBox(
              height: 200,
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
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                VerticalBar(
                                  text: labelMoney(x[index]['Total']),
                                  filledHeight:
                                      120 * x[index]['Total'] / maxValue,
                                  filledWidth: 25,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        minHeight: 1, minWidth: 1),
                                    child: Text(
                                      date,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 6.8,
                                          fontWeight: FontWeight.bold),
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
    } else {
      return const PrimaryContainer(
        opacity: 0.1,
        height: 150,
        child: Center(
          child: Text("do some habits to gather statistics on."),
        ),
      );
    }
  }
}
