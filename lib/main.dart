import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:achivement_box/pages/homePage/Bodies/providers/pageIndexProvider.dart';
import 'package:achivement_box/pages/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'db/sql.dart';
import 'rootProvider/ThemeProvider.dart';
import 'rootProvider/categoryProvider.dart';
import 'rootProvider/giftProvider.dart';
import 'rootProvider/habitProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDb();
  runApp(const MyApp());
}

/*final _defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: colors[getAccentColor()], brightness: Brightness.light);

final _defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: colors[getAccentColor()], brightness: Brightness.dark);*/

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
            create: (context) => ThemeProvider(),
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
            create: (context) => PageIndexProvider(),
          )
        ],
        child: Builder(builder: (context) {
          bool isDarkMode = getDarkMode();
          Color accentColor = context.watch<ThemeProvider>().AccentColor;
          return MaterialApp(
              title: 'Achievement Box',
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              theme: buildTheme(accentColor, isDarkMode),
              home: const HomePage());
        }));
  }
}
//
/*
*
*
*
*
*
* start with templating
* then db
* then provider
* -then design-
*
* x then locales
* refractoring
* ...
* */
