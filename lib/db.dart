import 'dart:io';

import 'package:intl/intl.dart';
import 'package:sqlite3/sqlite3.dart';

/*
* strike go to the log gift see the last two days then if the minus of them give 1 then add the strike else strike = 1
* SELECT TOP 1 Name from habit h inner join logHabit lh on h.Id = lh.Habit.Id Group by h.Id
* SELECT TOP 1 Name from gift ORDER BY NoOfUsed
* select TOP 1 Sum(lh.`Count` * h.Price) as total from habit h inner join logHabit lh on h.Id = lh.HabitId Group by lh.DateOnly Order by Sum(`Count` * Price) desc
* select TOP 7 lh.DateOnly , Sum(`Count` * Price) as total from habit h inner join logHabit lh on h.Id = lh.HabitId Group by lh.DateOnly Order by lh.DateOnly
* */
void createTablesIfNotExists(Database db) {
  const String createCategoryTable = '''
  CREATE TABLE IF NOT EXISTS category(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT unique,
  ColorId INTEGER DEFAULT 0,
  IconId INTEGER DEFAULT 0,
  EarnedXp INTEGER DEFAULT 0,
  MaxXp INTEGER DEFAULT 500,
  Level INTEGER DEFAULT 1
  );
  INSERT OR IGNORE INTO  category (Name) values('main');
  ''';
  const String createHabitTable = '''
  CREATE TABLE IF NOT EXISTS habit(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT,
  Category INTEGER,
  IsBad BOOLEAN,
  Price int,
  IconId INTEGER,
  Priority INTEGER,
  Hardness INTEGER,
  TimeInMinutes INTEGER,
  FOREIGN KEY(Category) REFERENCES category(Id)
  )''';
  const String createGiftTable = '''
  CREATE TABLE IF NOT EXISTS gift(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT,
  Price INTEGER,
  IconId INTEGER,
  NoOfUsed INTEGER DEFAULT 0
  )

  ''';
  const String createSettingTable = '''
  CREATE TABLE IF NOT EXISTS setting(
  Id INTEGER PRIMARY KEY,
  Name TEXT,
  Val INTEGER
  );
  INSERT OR IGNORE INTO setting(Id,Name,Val) values (1,'Coins',0),(2,'DarkMode',0),(3,'AccentColor',0),(4,'NotificationTime',0),(5,'TotalDays',1);  ''';
  const String createLogGiftTable = '''
  CREATE TABLE IF NOT EXISTS logGift(
  DateOnly TEXT,
  GiftId INTEGER, 
  Count INTEGER,
  PRIMARY KEY (GiftId, DateOnly),
  FOREIGN KEY (GiftId) REFERENCES gift(Id)
  )''';
  const String createLogHabitTable = '''
  CREATE TABLE IF NOT EXISTS logHabit(
  DateOnly TEXT,
  HabitId INTEGER, 
  Count INTEGER,
  PRIMARY KEY (HabitId, DateOnly),
  FOREIGN KEY (HabitId) REFERENCES habit(Id)
  )''';
  const List<String> sqlList = [
    createCategoryTable,
    createHabitTable,
    createGiftTable,
    createLogGiftTable,
    createLogHabitTable,
    createSettingTable
  ];
  for (String sql in sqlList) {
    db.execute(sql);
  }
  db.execute(createLevelTrigger);
  //db.execute("insert into logHabit values('$formattedDate',2,10);");
  ResultSet result = db.select("select * from category ");
  for (Row row in result) {
    print(row);
  }
}

//TODO err in this trigger if the xp is greater than 2 levels
const String createLevelTrigger = '''
CREATE TRIGGER IF NOT EXISTS trigIncreaseLevel 
AFTER UPDATE OF EarnedXp ON category 
BEGIN
    UPDATE category 
    SET EarnedXp = EarnedXp - MaxXp, 
        MaxXp = CAST(MaxXp * 1.25 AS INTEGER), 
        Level = Level + 1 
    WHERE EarnedXp >= MaxXp;
END;
''';

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

final coins = File("achievementBox.hcody");
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
