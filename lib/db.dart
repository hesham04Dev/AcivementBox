import 'package:sqlite3/sqlite3.dart';

void createTablesIfNotExists(Database db) {
  const String createCategoryTable = '''
  CREATE TABLE IF NOT EXISTS category(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT,
  ColorId INTEGER DEFAULT 0,
  IconId INTEGER DEFAULT 0,
  EarnedXp INTEGER DEFAULT 0,
  MaxXp INTEGER DEFAULT 500,
  Level INTEGER DEFAULT 1
  )''';

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
  Price int,
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

  /*//TODO create table level
  const String createLevelTable = '''
  CREATE TABLE IF NOT EXISTS level(
  ,
  HabitId INTEGER,
  Count INTEGER,
  PRIMARY KEY (HabitId, DateOnly),
  FOREIGN KEY (HabitId) REFERENCES habit(Id)

  ''';*/
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
  db.execute(createLevelTrigger);
  // db.execute("INSERT INTO category('Name') values('cat1')");
  /*db.execute(
      "INSERT INTO habit('Name','Category','IsBad','Price','Icon','Priority','Hardness','TimeInMinutes') VALUES ('Name',0,true,1.2,55,5,5,60)");*/
  //db.execute("DROP TABLE category");
  //print(1);
  // db.execute("insert into category (name) values('main')");

  ResultSet result = db.select("select * from category where Name = 'main'");
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
    required int timeInMinutes}) async {
  db.execute(
      "INSERT INTO habit('Name','Category','IsBad','Price','Icon','Priority','Hardness','TimeInMinutes') VALUES ('$name',$category,$isBad,$price,$iconId,$priority,$hardness,$timeInMinutes)");
}

late Database db;
ResultSet getHabits() {
  ResultSet resultSet = db.select("SELECT * FROM habit ;");
  '''SELECT habit.Id ,habit.Name,category.Name,IsBad,Price,Icon,Priority,Hardness,TimeInMinutes, FROM habit , category
 WHERE category.Id = habit.category
 ''';
/*for (Row row in resultSet) {
print(row);
}*/
  return resultSet;
}

Row getLevel({String name = "main"}) {
  //db.execute("insert into category (Name) values ('main')");
  ResultSet result = db.select("select * from category where Name = '$name'");

  return result[0];
}

void updateLevel({String name = "main", required int value}) {
  db.execute("update category set EarnedXp = EarnedXp + $value");
}
