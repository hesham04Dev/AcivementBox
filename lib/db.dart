import 'dart:io';

import 'package:intl/intl.dart';
import 'package:sqlite3/sqlite3.dart';

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
  Icon INTEGER,
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
  Icon INTEGER,
  NoOfUsed INTEGER DEFAULT 0
  )

  ''';
  // is possible to create a new type of gifts that depends on habits not on the coins
  const String createGiftOnHabitTable = '''
  CREATE TABLE IF NOT EXISTS giftOnHabit(
  GiftId INTEGER,
  HabitId INTEGER,
  RepeatOfHabit INTEGER,
  PRIMARY KEY (GiftId, HabitId),
  FOREIGN KEY (HabitId) REFERENCES habit(Id),
  FOREIGN KEY (GiftId) REFERENCES gift(Id)
  )''';
  const String createUserTable = '''
  CREATE TABLE IF NOT EXISTS setting(
  Id INTEGER PRIMARY KEY,
  Name TEXT,
  val INTEGER
  );
  INSERT OR IGNORE INTO setting(Id,Name,val) values (1,'Coins',0)
  ''';
  /////
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
    createGiftOnHabitTable,
    createLogGiftTable,
    createLogHabitTable,
    createUserTable
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
      "INSERT INTO habit('Name','Category','IsBad','Price','Icon','Priority','Hardness','TimeInMinutes') VALUES ('$name',$category,$isBad,$price,$iconId,$priority,$hardness,$timeInMinutes)");
}

void newGift({
  required String name,
  required int price,
  required int iconId,
}) {
  db.execute(
      "INSERT INTO gift('Name','Price','Icon') VALUES ('$name',$price,$iconId)");
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
  ResultSet r = db.select("select val from setting where Name = 'Coins'");

  return r[0]["val"];
}

updateCoins(int num) {
  db.execute("update setting set val =$num where Name = 'Coins'");
}

getCategories() {
  return db.select("select * from category");
}
