import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import '../../../models/PrimaryContainer.dart';
import '../models/log.dart';

class LogContainer extends StatelessWidget {
  final sqlite.ResultSet dates;
  final Log log;

  const LogContainer({super.key, required this.dates, required this.log});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dates.length,
      itemBuilder: (BuildContext context, int index) {
        sqlite.ResultSet rows =
            log.getLogsPerDate(dates[index]["DateOnly"].toString());
        var logPerDay = [];
        for (sqlite.Row row in rows) {
          var widget = PrimaryContainer(
              paddingHorizontal: 20,
              padding: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("${row['Name']}"), Text("${row['Count']}")],
                ),
              ));
          logPerDay.add(widget);
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [Text("${dates[index]["DateOnly"]} "), ...logPerDay],
          ),
        );
      },
    );
  }
}
