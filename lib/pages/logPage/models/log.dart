import 'package:achivement_box/db/sql.dart';

abstract class Log {
  final String name;
  Log(this.name);
  getLogsPerDate(String date);
}

class LogHabit extends Log {
  LogHabit() : super("Habit");
  @override
  getLogsPerDate(String date) {
    return getLogHabitByDate(date);
  }
}

class LogGift extends Log {
  LogGift() : super("Gift");
  @override
  getLogsPerDate(String date) {
    return getLogGiftByDate(date);
  }
}
