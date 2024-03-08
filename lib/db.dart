import 'package:sqlite3/sqlite3.dart';

void createTablesIfNotExists(Database db) {
  const String createCategoryTable = '''
  CREATE TABLE IF NOT EXISTS category(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT,
  Color INTEGER,
  Icon INTEGER,
  EarnedXp INTEGER,
  MaxXp INTEGER,
  level INTEGER
  )''';
  const String createHabitTable = '''
  CREATE TABLE IF NOT EXISTS habit(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT,
  Type TEXT,
  Price FLOAT,
  Icon INTEGER,
  Priority INTEGER,
  Hardness INTEGER,
  TimeInMinutes INTEGER
  )''';
  const String createGiftTable = '''
  CREATE TABLE IF NOT EXISTS gift(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT,
  Price FLOAT,
  Icon INTEGER
  )''';
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
    createLogHabitTable
  ];
  for (String sql in sqlList) {
    db.execute(sql);
  }
  db.execute(
      "INSERT INTO habit('Name','Type','Price','Icon','Priority','Hardness','TimeInMinutes') VALUES ('Name','Type',1.2,55,5,5,60)");
  ResultSet resultSet = db.select("SELECT * FROM habit ;");
  for (Row row in resultSet) {
    print(row);
  }
  //print(1);
}
