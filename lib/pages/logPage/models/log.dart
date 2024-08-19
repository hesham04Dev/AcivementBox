import '../../../db/db.dart';

abstract class Log {
  final String name;
  Log(this.name);
  getLogsPerDate(String date);
}

class LogHabit extends Log {
  LogHabit() : super("Habit");
  @override
  getLogsPerDate(String date) {
    return db.sql.habits.getLogByDate(date);
  }
}

class LogGift extends Log {
  LogGift() : super("Gift");
  @override
  getLogsPerDate(String date) {
    return db.sql.gifts.getLogByDate(date);
  }
}
