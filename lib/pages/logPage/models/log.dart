import "package:localization_lite/translate.dart";


import '../../../db/db.dart';

abstract class Log {
  final String name;
  Log(this.name);
  getLogsPerDate(String date);
}

class LogHabit extends Log {
  LogHabit() : super(tr("habits"));
  @override
  getLogsPerDate(String date) {
    return db.sql.habits.getLogByDate(date);
  }
}

class LogGift extends Log {
  LogGift() : super(tr("gifts"));
  @override
  getLogsPerDate(String date) {
    return db.sql.gifts.getLogByDate(date);
  }
}
