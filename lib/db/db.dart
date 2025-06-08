import 'dart:io';

import 'sql_class.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

/*
* strike go to the log habit see the last two days then if the minus of them give 1 then add the strike else strike = 1
*/ /*
void createTablesIfNotExists(Database db) {
  const String createCategoryTable = '''
  CREATE TABLE IF NOT EXISTS category(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT unique,
  IconId INTEGER DEFAULT 0,
  EarnedXp INTEGER DEFAULT 0,
  MaxXp INTEGER DEFAULT 100,
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
  IsArchived BOOLEAN DEFAULT 0,
  FOREIGN KEY(Category) REFERENCES category(Id)
  )''';
  const String createGiftTable = '''
  CREATE TABLE IF NOT EXISTS gift(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT,
  Price INTEGER,
  IconId INTEGER,
  IsArchived BOOLEAN DEFAULT 0,
  NoOfUsed INTEGER DEFAULT 0
  )

  ''';
  const String createSettingTable = '''
  CREATE TABLE IF NOT EXISTS setting(
  Id INTEGER PRIMARY KEY,
  Name TEXT,
  Val INTEGER
  );
  INSERT OR IGNORE INTO setting(Id,Name,Val) values (1,'Coins',0),(2,'DarkMode',0),(3,'AccentColor',0),(4,'NotificationTime',0),(5,'Streak',1),(6,'ListView',0);  ''';
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
  ResultSet result = db.select("select * from category ");
  for (Row row in result) {
    print(row);
  }
}
*/
class DbHelper {
  final _supportDir = getApplicationSupportDirectory();
  late final String dbPath;

  late Database db;
  late Sql sql;

  Future<void> openDb() async {
    final dir = await _supportDir;
    dbPath = "${dir.path}/hcody_ab.db";
    print(dbPath);
    _restoreIfExists();
    db = sqlite3.open(dbPath);
    createTablesIfNotExists(db);
    sql = Sql(db);
    sql.settings.updateStreak();
  }

  void _restoreIfExists() async {
    var dir = await _supportDir;
    File restored = File('${dir.path}/restored.db');
    if (await restored.exists()) {
      print("restoring");
      File old = File(dbPath);
      await old.delete();
      await restored.rename(dbPath);
    }
  }

  void createTablesIfNotExists(Database db) {
    const String createCategoryTable = '''
  CREATE TABLE IF NOT EXISTS category(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT unique,
  IconId INTEGER DEFAULT 0,
  EarnedXp INTEGER DEFAULT 0,
  MaxXp INTEGER DEFAULT 100,
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
  IsArchived BOOLEAN DEFAULT 0,
  FOREIGN KEY(Category) REFERENCES category(Id)
  )''';
    const String createGiftTable = '''
  CREATE TABLE IF NOT EXISTS gift(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT,
  Price INTEGER,
  IconId INTEGER,
  IsArchived BOOLEAN DEFAULT 0,
  NoOfUsed INTEGER DEFAULT 0
  )

  ''';
    const String createSettingTable = '''
  CREATE TABLE IF NOT EXISTS setting(
  Id INTEGER PRIMARY KEY,
  Name TEXT,
  Val INTEGER
  );
  INSERT OR IGNORE INTO setting(Id,Name,Val) values (1,'Coins',0),(2,'DarkMode',0),(3,'AccentColor',0),(4,'NotificationTime',0),(5,'Streak',1),(6,'ListView',0);  ''';
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
  }
}

var db = DbHelper();
