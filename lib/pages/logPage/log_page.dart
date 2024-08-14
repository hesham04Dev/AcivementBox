import 'package:achivement_box/db/sql.dart';
import 'package:achivement_box/models/habitGiftTabPage.dart';
import 'package:achivement_box/pages/logPage/models/log.dart';
import 'package:achivement_box/pages/logPage/widgets/log_container.dart';
import 'package:flutter/material.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

class LogPage extends StatelessWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    sqlite.ResultSet logHabitDates = getDatesOfLogHabit();
    sqlite.ResultSet logGiftDates = getDatesOfLogGift();
    return HabitGiftTabPage(
        tabBarView: TabBarView(
      children: [
        LogContainer(dates: logHabitDates, log: LogHabit()),
        LogContainer(dates: logGiftDates, log: LogGift())
      ],
    ));
  }
}
