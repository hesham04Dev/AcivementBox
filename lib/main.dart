import 'package:flutter/material.dart';
import 'package:sqlite3/sqlite3.dart';

import 'db.dart';
import 'pages/homePage/homePage.dart';

void main() {
  final Database db = sqlite3.open("hesham.db");
  createTablesIfNotExists(db);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
        fontFamily: "dubai",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

/*
*
* TODO page of edit habit
*
*
*
* start with templating
* then db
* then provider
* then design
* then locales
* refractoring
* ...
* */
