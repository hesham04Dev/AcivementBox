import 'package:intl/intl.dart';
import 'package:sqlite3/sqlite3.dart';

import '../models/Category.dart';
import '../models/gift.dart';
import '../models/habit.dart';

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
    //print(row);
  }*/

  return resultSet;
}

ResultSet getGifts() {
  ResultSet resultSet = db.select("SELECT * FROM gift ;");
  return resultSet;
}

ResultSet getMostUsedGifts(int limit) {
  ResultSet resultSet = db.select(
      '''SELECT * FROM gift  WHERE NoOfUsed > 0  ORDER BY NoOfUsed DESC  LIMIT $limit;''');
  return resultSet;
}

getLevel({required String name}) {
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

int? updateLevel({required int value, required int id}) {
  Row res = db.select("select * from category where id =$id")[0];
  Category category = Category(
      id: id,
      name: res['Name'],
      colorId: res['ColorId'],
      iconId: res['IconId'],
      earnedXp: res['EarnedXp'],
      level: res['Level'],
      maxXp: res['MaxXp']);
  bool isLevelIncrease = false;
  category.earnedXp += value;
  while (category.earnedXp >= category.maxXp) {
    category.earnedXp -= category.maxXp;
    category.maxXp = (category.maxXp * 1.25).toInt();
    category.level += 1;
    isLevelIncrease = true;
  }
  if (isLevelIncrease) {
    db.execute(
        "update category set EarnedXp = ${category.earnedXp}, MaxXp = ${category.maxXp},Level = ${category.level} where Id = ${category.id} ");
    return category.level;
  }
  db.execute(
      "update category set EarnedXp = EarnedXp + $value where Id = ${category.id}");
  return null;
}

int? removeLevel({required int value, required int id}) {
  Row res = db.select("select * from category where id =$id")[0];
  Category category = Category(
      id: id,
      name: res['Name'],
      colorId: res['ColorId'],
      iconId: res['IconId'],
      earnedXp: res['EarnedXp'],
      level: res['Level'],
      maxXp: res['MaxXp']);
  bool isLevelDecrease = false;
  category.earnedXp -= value;
  while (category.earnedXp < 0) {
    category.maxXp = (category.maxXp / 1.25).toInt();
    category.earnedXp += category.maxXp;
    category.level -= 1;
    isLevelDecrease = true;
  }
  if (isLevelDecrease) {
    db.execute(
        "update category set EarnedXp = ${category.earnedXp}, MaxXp = ${category.maxXp},Level = ${category.level} where Id = ${category.id} ");
    return category.level;
  } else {
    db.execute(
        "update category set EarnedXp = ${category.earnedXp} where Id = ${category.id}");
    return null;
  }
}

int getCoins() {
  ResultSet r = db.select("select Val from setting where Name = 'Coins'");
  return r[0]["Val"];
}

int getStreak() {
  ResultSet r = db.select("select Val from setting where Name = 'Streak'");
  return r[0]["Val"];
}

String? getLastDay() {
  ResultSet r =
      db.select("select DateOnly from logHabit Order by DateOnly DESC Limit 1");
  return r.isEmpty ? null : r[0]["DateOnly"];
}

updateCoins(int num) {
  db.execute("update setting set Val =$num where Name = 'Coins'");
}

getCategories() {
  return db.select("select * from category");
}

getCategory(int id) {
  return db.select("select * from category where Id = $id")[0];
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
  for (var r in x) {}
  return x;
}

getTopGift() {
  var x = db.select('''
  SELECT Name , NoOfUsed as Total
FROM gift
ORDER BY NoOfUsed DESC
LIMIT 1;
  ''');

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

updateHabit(Habit habit) {
  db.execute('''UPDATE habit set Name = '${habit.name}',
  Category = ${habit.categoryId},
  IsBad = ${habit.isBadHabit},
  IconId = ${habit.iconId},
  Priority = ${habit.priority},
  Hardness = ${habit.hardness},
  Price = ${habit.price},
  TimeInMinutes = ${habit.timeInMinutes}
  WHERE Id = ${habit.id} ''');
}

updateGift(Gift gift) {
  "('Name','Category','IsBad','Price','IconId','Priority','Hardness','TimeInMinutes')";
  db.execute('''UPDATE gift set Name = '${gift.name}',
  IconId = ${gift.iconId},
  Price = ${gift.price}
  WHERE Id = ${gift.id} ''');
}

void updateStreak() {
  DateTime lastDay = DateTime.parse(getLastDay() ?? DateTime.now().toString());
  print(now.difference(lastDay).inDays);
  int diff = now.difference(lastDay).inDays;
  if (diff == 1) {
    db.execute('''UPDATE setting set Val = Val +1  WHERE Name = 'Streak' ''');
  } else if (diff != 0) {
    db.execute('''UPDATE setting set Val = 1  WHERE Name = 'Streak' ''');
  }
}
