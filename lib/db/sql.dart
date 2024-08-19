/*import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../models/Category.dart';
import '../models/gift.dart';
import '../models/habit.dart';
import 'db.dart';

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

/*TODO fix sql injection
*    await db.execute(
    "UPDATE category SET EarnedXp = ?, MaxXp = ?, Level = ? WHERE Id = ?",
    [category.earnedXp, category.maxXp, category.level, category.id]
  );
* */
void deleteHabit({required int id}) {
  db.execute("delete from logHabit where HabitId = ?", [id]);
  db.execute("delete from habit where Id = $id");
}

void archiveHabit({required int id}) {
  db.execute("update habit set IsArchived = 1  where Id = ?", [id]);
}

void archiveGift({required int id}) {
  db.execute("update gift set IsArchived = 1  where Id = ?", [id]);
}

void deleteCategory({required int id}) {
  db.execute("update habit set Category = 1 where Category = $id");
  db.execute("delete from category where Id = $id");
}

void deleteGift({required int id}) {
  db.execute("delete from logGift where GiftId = $id");
  db.execute("delete from gift where Id = $id");
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
  required int iconId,
}) {
  db.execute("INSERT INTO category('Name','IconId') VALUES ('$name',$iconId)");
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
) AS logHabit ON habit.Id = logHabit.HabitId
WHERE IsArchived =0;
  ''');
  return resultSet;
}

ResultSet getArchivedHabits() {
  ResultSet resultSet = db.select('''
  SELECT * FROM habit WHERE IsArchived = 1;
  ''');
  return resultSet;
}

void printResults(ResultSet resultSet) {
  for (Row row in resultSet) {
    print(row);
  }
}

ResultSet getGifts() {
  ResultSet resultSet = db.select("SELECT * FROM gift where IsArchived =0;");
  return resultSet;
}

ResultSet getArchivedGifts() {
  ResultSet resultSet = db.select("SELECT * FROM gift where IsArchived =1;");
  return resultSet;
}

ResultSet getMostUsedGifts(int limit) {
  ResultSet resultSet = db.select(
      '''SELECT * FROM gift  WHERE NoOfUsed > 0 and IsArchived = 0 ORDER BY NoOfUsed DESC  LIMIT $limit;''');
  return resultSet;
}

getLevel({required String name}) {
  ResultSet result = db.select("select * from category where Name = '$name'");
  return result[0];
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

int updateLevel({required int value, required int id}) {
  Row res = db.select("select * from category where id =$id")[0];
  Category category = Category(
      id: id,
      name: res['Name'],
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
  return 0;
}

int? removeLevel({required int value, required int id}) {
  Row res = db.select("select * from category where id =$id")[0];
  Category category = Category(
      id: id,
      name: res['Name'],
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
  return db.select(
      "SELECT * FROM category ORDER BY CASE WHEN id = 1 THEN 0 ELSE 1 END, Level DESC;");
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

getLogHabitByDate(String date) {
  return db.select(
      "select  logHabit.*,habit.Name from logHabit inner join habit on logHabit.HabitId = habit.Id where DateOnly = '$date'");
}

getLogGiftByDate(String date) {
  return db.select(
      "select  logGift.*,gift.Name from logGift inner join gift on logGift.GiftId = gift.Id where DateOnly = '$date'");
}

getDatesOfLogHabit() {
  return db
      .select("select distinct DateOnly from logHabit order by DateOnly desc ");
}

getDatesOfLogGift() {
  return db
      .select("select distinct DateOnly from logGift order by DateOnly desc ");
}

getWeeklyData() {
  var x = db.select('''
SELECT lh.DateOnly, SUM(lh.Count * h.Price) AS Total
FROM habit AS h
INNER JOIN logHabit AS lh ON h.Id = lh.HabitId
GROUP BY lh.DateOnly
ORDER BY lh.DateOnly desc
LIMIT 7;
  ''');

  return x;
}

getAccentColorIndex() {
  var x = db.select('''SELECT Val from setting where Name = 'AccentColor' ''');
  return x[0]['Val'];
}

setAccentColor(val) {
  db.execute("UPDATE setting set Val = $val WHERE Name = 'AccentColor' ");
}

bool getDarkMode() {
  var x = db.select('''SELECT Val from setting where Name = 'DarkMode' ''');
  if (x[0]['Val'] == 1) {
    return true;
  } else {
    return false;
  }
}

bool isListView() {
  var x = db.select('''SELECT Val from setting where Name = 'ListView' ''');
  if (x[0]['Val'] == 1) {
    return true;
  } else {
    return false;
  }
}

setDarkMode(val) {
  db.execute("UPDATE setting set Val = $val WHERE Name = 'DarkMode' ");
}

setIsListView(bool val) {
  db.execute(
      "UPDATE setting set Val = ${val ? 1 : 0} WHERE Name = 'ListView' ");
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

updateCategory({required int id, required int iconId, required String name}) {
  print(iconId);
  db.execute('''UPDATE category set Name = '$name',
  IconId = $iconId
  WHERE Id = $id ''');
}

updateGift(Gift gift) {
  "('Name','Category','IsBad','Price','IconId','Priority','Hardness','TimeInMinutes')";
  db.execute('''UPDATE gift set Name = '${gift.name}',
  IconId = ${gift.iconId},
  Price = ${gift.price}
  WHERE Id = ${gift.id} ''');
}

updateGiftCount({required int id, String sign = '+'}) {
  if (sign == '+' || sign == '-') {
    db.execute('''
    update  gift set NoOfUsed = NoOfUsed $sign 1 where
    Id = $id;
    ''');
  } else
    print("invalid operation in update gift");
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

Future<void> openDb() async {
  var dir = await getApplicationSupportDirectory();
  String dbPath = '${dir.path}/hcody_ab.db';
  print(dbPath);
  File restored = File('${dir.path}/restored.db');
  if (await restored.exists()) {
    print(dbPath);
    print("restoreing");
    File old = File(dbPath);
    await old.delete();
    await restored.rename(dbPath);
  }
  db = sqlite3.open(dbPath);
  createTablesIfNotExists(db);
  updateStreak();
}

addToHabitLog(int id) {
  db.execute('''
      insert into logHabit values('$formattedDate',$id,1)
      ''');
}

updateHabitLog({required int id, required int count}) {
  db.execute('''
      update  logHabit set
      count = $count
      where DateOnly = '$formattedDate'
      and HabitId =$id
      ''');
}

deleteFromHabitLog(int id) {
  db.execute('''
      delete from logHabit where HabitId = $id and DateOnly = '$formattedDate'
      ''');
}

addToGiftLog(int id) {
  db.execute('''
      insert into logGift values('$formattedDate',$id,1)
      ''');
}

updateGiftLog({required int id, required int count}) {
  db.execute('''
      update  logGift set
      count = $count
      where DateOnly = '$formattedDate'
      and GiftId =$id
      ''');
}

deleteFromLogGift(int id) {
  db.execute('''
      delete from logGift where GiftId = $id and DateOnly = '$formattedDate'
      ''');
}
*/
