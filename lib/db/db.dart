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
  // db.execute(createLevelTrigger);
  //db.execute("insert into logHabit values('$formattedDate',2,10);");
  ResultSet result = db.select("select * from category ");
  for (Row row in result) {
    print(row);
  }
}
/*
const String createLevelTrigger = '''
CREATE TRIGGER IF NOT EXISTS trigIncreaseLevel 
AFTER UPDATE OF EarnedXp ON category 
BEGIN
  while EarnedXp >= MaxXp
  BEGIN
    UPDATE category 
    SET EarnedXp = EarnedXp - MaxXp, 
        MaxXp = CAST(MaxXp * 1.25 AS INTEGER), 
        Level = Level + 1 
    WHERE EarnedXp >= MaxXp;
  END
END;
''';*/
