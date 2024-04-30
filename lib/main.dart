import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:achivement_box/pages/homePage/provider/giftProvider.dart';
import 'package:achivement_box/pages/homePage/provider/habitProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'db.dart';
import 'pages/homePage/homePage.dart';

void main() {
  //db = sqlite3.openInMemory();
  db = sqlite3.open("h.db");
  createTablesIfNotExists(db);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HabitProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CoinsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GiftProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            centerTitle: true,
          ),
          fontFamily: "dubai",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
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
