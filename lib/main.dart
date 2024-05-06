import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:achivement_box/rootProvider/iconProvider.dart';
import 'package:flutter/material.dart';
import "package:path/path.dart" as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'db/db.dart';
import 'db/sql.dart';
import 'output/generated/colors.dart';
import 'pages/homePage/homePage.dart';
import 'rootProvider/categoryProvider.dart';
import 'rootProvider/giftProvider.dart';
import 'rootProvider/habitProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //db = sqlite3.openInMemory();
  var dir = await getApplicationSupportDirectory();
  String fileName = path.join(dir.path, 'my_app2.db');
  db = sqlite3.open(fileName);
  createTablesIfNotExists(db);
  runApp(const MyApp());
  //db.dispose();
}

final _defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: colors[getAccentColor()], brightness: Brightness.light);

final _defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: colors[getAccentColor()], brightness: Brightness.dark);

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
          ChangeNotifierProvider(
            create: (context) => CategoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => IconProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          themeMode: getDarkMode() == 1 ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              dialogTheme: const DialogTheme(backgroundColor: Colors.white),
              iconButtonTheme: IconButtonThemeData(
                  style: ButtonStyle(
                      iconColor: MaterialStatePropertyAll(
                _defaultLightColorScheme.onPrimary,
              ))),
              dialogBackgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              textButtonTheme: const TextButtonThemeData(
                  style: ButtonStyle(
                      textStyle: MaterialStatePropertyAll(TextStyle(
                          color: Colors.black,
                          fontFamily: "Dubai",
                          fontSize: 19)))),
              floatingActionButtonTheme:
                  const FloatingActionButtonThemeData(shape: CircleBorder()),
              colorScheme: _defaultLightColorScheme,
              useMaterial3: true,
              fontFamily: "Dubai",
              appBarTheme: AppBarTheme(
                //backgroundColor: _defaultLightColorScheme.primary,
                titleTextStyle: TextStyle(
                    fontFamily: "Dubai",
                    color: _defaultLightColorScheme.primary,
                    fontSize: 20),
                centerTitle: true,
              ),
              drawerTheme: const DrawerThemeData(
                backgroundColor: Colors.white,
              )),
          darkTheme: ThemeData(
            dialogTheme: const DialogTheme(backgroundColor: Colors.black87),
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(
              _defaultDarkColorScheme.onPrimary,
            ))),
            inputDecorationTheme: const InputDecorationTheme(
                fillColor: Colors.white10,
                hintStyle: TextStyle(color: Colors.white70)),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    textStyle: MaterialStatePropertyAll(TextStyle(
              color: _defaultDarkColorScheme.primary,
              fontFamily: "Dubai",
            )))),
            scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
            floatingActionButtonTheme:
                const FloatingActionButtonThemeData(shape: CircleBorder()),
            iconTheme: IconThemeData(
              color: _defaultDarkColorScheme.primary,
            ),
            colorScheme: _defaultDarkColorScheme,
            useMaterial3: true,
            fontFamily: "Dubai",
            appBarTheme: AppBarTheme(
              backgroundColor: const Color.fromARGB(255, 50, 50, 50),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Dubai",
                fontSize: 20,
                color: _defaultDarkColorScheme.primary,
              ),
              centerTitle: true,
            ),
          ),
          home: const HomePage(),
        ));
  }
}
//TODO create dataProvider
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
//TODO create dataprovider
