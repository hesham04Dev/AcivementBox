import 'package:intl/intl.dart';
import 'package:sqlite3/sqlite3.dart';

void newHabit(
    {required String name,
    required int category,
    required bool isBad,
    required int price,
    required int iconId,
    required int priority,
    required int hardness,
    required int timeInMinutes}) {
  db.execute(
      "INSERT INTO habit('Name','Category','IsBad','Price','IconId','Priority','Hardness','TimeInMinutes') VALUES ('$name',$category,$isBad,$price,$iconId,$priority,$hardness,$timeInMinutes)");
}

void newGift({
  required String name,
  required int price,
  required int iconId,
}) {
  db.execute(
      "INSERT INTO gift('Name','Price','IconId') VALUES ('$name',$price,$iconId)");
}

void newCategory({
  required String name,
  required int colorId,
  required int iconId,
}) {
  db.execute(
      "INSERT INTO category('Name','ColorId','IconId') VALUES ('$name',$colorId,$iconId)");
}

late Database db;

ResultSet getHabits() {
  /*ResultSet resultSet = db.select(
      "SELECT habit.*, count FROM habit inner join (select HabitId,count form logHabit where DateOnly = $formattedDate)   ;");*/
  ResultSet resultSet = db.select('''
  SELECT habit.*, logHabit.count AS count
FROM habit
LEFT JOIN (
    SELECT HabitId, count
    FROM logHabit
    WHERE DateOnly = '$formattedDate'
) AS logHabit ON habit.Id = logHabit.HabitId;
  ''');
/*
  for (Row row in resultSet) {
    print(row);
  }*/

  return resultSet;
}

ResultSet getGifts() {
  ResultSet resultSet = db.select("SELECT * FROM gift ;");

  return resultSet;
}

ResultSet getMostUsedGifts() {
  int num = 3;
  ResultSet resultSet = db.select(
      "SELECT  * FROM gift where NoOfUsed > 0 ORDER BY NoOfUsed desc LIMIT $num ;");

  return resultSet;
}

Row getLevel({required String name}) {
  //db.execute("insert into category (Name) values ('main')");
  ResultSet result = db.select("select * from category where Name = '$name'");

  return result[0];
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);
Map<int, int> getHabitCount() {
  '''
  select habitId,count form logHabit where 
  DateOnly = $formattedDate
  ''';
  return {};
}

void updateLevel({required int id, required int value}) {
  db.execute(
      "update category set EarnedXp = EarnedXp + $value where Id = '$id' or Name = 'main'");
}

int getCoins() {
  //db.execute("insert into user values (1,'dd',0);");
  ResultSet r = db.select("select Val from setting where Name = 'Coins'");

  return r[0]["Val"];
}

updateCoins(int num) {
  db.execute("update setting set Val =$num where Name = 'Coins'");
}

getCategories() {
  return db.select("select * from category");
}

getTopHabit() {
  ResultSet x = db.select('''
SELECT h.Name , Sum(lh.Count) as Total
FROM habit h
INNER JOIN logHabit lh ON h.Id = lh.HabitId
GROUP BY h.Id
ORDER BY  Sum(lh.Count) DESC
LIMIT 1;
  ''');
  for (var r in x) {
    print(r);
  }
  return x;
}

getTopGift() {
  var x = db.select('''
  SELECT Name , NoOfUsed as Total
FROM gift
ORDER BY NoOfUsed DESC
LIMIT 1;
  ''');
  for (var r in x as List<dynamic>) {
    print(r);
  }
  return x;
}

getTopDay() {
  var x = db.select('''
SELECT lh.DateOnly , SUM(lh.Count * h.Price) AS Total
FROM habit AS h
INNER JOIN logHabit AS lh ON h.Id = lh.HabitId
GROUP BY lh.DateOnly
ORDER BY SUM(lh.Count * h.Price) DESC
LIMIT 1;
  ''');
  for (var r in x as List<dynamic>) {
    print(r);
  }
  return x;
}

getWeeklyData() {
  var x = db.select('''
SELECT lh.DateOnly, SUM(lh.Count * h.Price) AS Total
FROM habit AS h
INNER JOIN logHabit AS lh ON h.Id = lh.HabitId
GROUP BY lh.DateOnly
ORDER BY lh.DateOnly
LIMIT 7;
  ''');
  for (var r in x as List<dynamic>) {
    print(r);
  }
  return x;
}

getAccentColor() {
  var x = db.select('''SELECT Val from setting where Name = 'AccentColor' ''');
  return x[0]['Val'];
}

setAccentColor(val) {
  db.execute("UPDATE setting set Val = $val WHERE Name = 'AccentColor' ");
}

getDarkMode() {
  var x = db.select('''SELECT Val from setting where Name = 'DarkMode' ''');
  return x[0]['Val'];
}

setDarkMode(val) {
  db.execute("UPDATE setting set Val = $val WHERE Name = 'DarkMode' ");
}

getNotificationTime() {
  var x =
      db.select('''SELECT Val from setting where Name = 'NotificationTime' ''');
  return x[0]['Val'];
}

setNotificationTime(val) {
  db.execute("UPDATE setting set Val = $val WHERE Name = 'NotificationTime' ");
}
