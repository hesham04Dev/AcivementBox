import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:achivement_box/rootProvider/bottomNavBarProvider.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
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

const kWhite = Colors.white;
const kLightGrey = const Color(0xFFE8E8E8);
const kDarkGrey = const Color(0xFF303030);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //db = sqlite3.openInMemory();
  var dir = await getApplicationSupportDirectory();
  String fileName = path.join(dir.path, 'my_app4.db');
  db = sqlite3.open(fileName);
  createTablesIfNotExists(db);
  updateStreak();
  runApp(const MyApp());
  //db.dispose();
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
    return DynamicColorTheme(
        data: (Color color, bool isDark) {
          return _buildTheme(
              color, isDark); // TODO define your own buildTheme method here
        },
        defaultColor: colors[0],
        defaultIsDark: false,
        themedWidgetBuilder: (BuildContext context, ThemeData theme) {
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
                  create: (context) => ColorProvider(),
                ),
              ],
              child: MaterialApp(
                title: 'Flutter Demo',
                themeMode:
                    getDarkMode() == 1 ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                theme: theme,
                /*theme: ThemeData(
                  switchTheme: SwitchThemeData(
                    trackOutlineColor: WidgetStatePropertyAll(
                        colors[getAccentColor()].withOpacity(0.2)),
                    thumbColor: WidgetStatePropertyAll(
                        colors[getAccentColor()].withOpacity(0.2)),
                  ),
                  dialogTheme: const DialogTheme(backgroundColor: Colors.white),
                  iconButtonTheme: IconButtonThemeData(
                      style: ButtonStyle(
                          iconColor: WidgetStatePropertyAll(
                    _defaultLightColorScheme.onPrimary,
                  ))),
                  dialogBackgroundColor: Colors.white,
                  scaffoldBackgroundColor: Colors.white,
                  textButtonTheme: const TextButtonThemeData(
                      style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(TextStyle(
                              color: Colors.black,
                              fontFamily: "Dubai",
                              fontSize: 19)))),
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                          shape: CircleBorder()),
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
                  ),
                ),
                darkTheme: ThemeData(
                  dialogTheme:
                      const DialogTheme(backgroundColor: Colors.black87),
                  iconButtonTheme: IconButtonThemeData(
                      style: ButtonStyle(
                          iconColor: WidgetStatePropertyAll(
                    _defaultDarkColorScheme.onPrimary,
                  ))),
                  inputDecorationTheme: const InputDecorationTheme(
                      fillColor: Colors.white10,
                      hintStyle: TextStyle(color: Colors.white70)),
                  textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(TextStyle(
                    color: _defaultDarkColorScheme.primary,
                    fontFamily: "Dubai",
                  )))),
                  scaffoldBackgroundColor:
                      const Color.fromARGB(255, 50, 50, 50),
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                          shape: CircleBorder()),
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
                ),*/
                home: const HomePage(),
              ));
        });
  }

  ThemeData _buildTheme(Color accentColor, bool isDark) {
    final ThemeData base = isDark ? ThemeData.dark() : ThemeData.light();
    final Color primaryColor = isDark ? kDarkGrey : kWhite;
    final swatch = ColorScheme.fromSwatch(
        primarySwatch: colors[getAccentColor()],
        brightness: isDark ? Brightness.dark : Brightness.light);
    return base.copyWith(
      segmentedButtonTheme: SegmentedButtonThemeData(
          style: SegmentedButton.styleFrom(
        selectedBackgroundColor: swatch.primary,
      )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          elevation: 0,
          unselectedItemColor: Colors.grey,
          selectedItemColor: swatch.primary,
          selectedLabelStyle: TextStyle(color: swatch.primary)),
      switchTheme: SwitchThemeData(
        trackOutlineColor:
            WidgetStatePropertyAll(swatch.primary.withOpacity(0.2)),
        thumbColor: WidgetStatePropertyAll(swatch.primary.withOpacity(0.2)),
      ),
      dialogTheme:
          DialogTheme(backgroundColor: isDark ? Colors.black : Colors.white),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(
        swatch.primary,
      ))),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle:
              TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle: WidgetStatePropertyAll(TextStyle(
        color: swatch.primary,
        fontFamily: "Dubai",
      )))),
      scaffoldBackgroundColor: isDark ? kDarkGrey : kWhite,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: CircleBorder(),
          backgroundColor: swatch.primary.withOpacity(0.7)),
      iconTheme: IconThemeData(
        color: swatch.primary,
      ),
      colorScheme: swatch,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? kDarkGrey : kWhite,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Dubai",
          fontSize: 20,
          color: swatch.primary,
        ),
        centerTitle: true,
      ),
      hintColor: accentColor,
      cardColor: primaryColor,
      primaryColor: primaryColor,
      primaryIconTheme: base.primaryIconTheme.copyWith(
        color: accentColor,
      ),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, accentColor),
      textSelectionTheme: _buildTextSelectionTheme(
          base.textSelectionTheme, accentColor, isDark),
      textTheme: _buildTextTheme(base.textTheme, accentColor),
    );
  }

  TextTheme _buildTextTheme(TextTheme base, Color color) {
    return base.copyWith(
      bodyMedium: base.bodyMedium!.copyWith(
        fontSize: 16,
      ),
      bodyLarge: base.bodyLarge!.copyWith(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: base.labelLarge!.copyWith(
        color: color,
      ),
      bodySmall: base.bodySmall!.copyWith(
        color: color,
        fontSize: 14,
      ),
      headlineSmall: base.headlineSmall!.copyWith(
        color: color,
        fontSize: 22,
      ),
      titleMedium: base.titleMedium!.copyWith(
        color: color,
        fontSize: 16,
      ),
      titleLarge: base.titleLarge!.copyWith(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextSelectionThemeData _buildTextSelectionTheme(
      TextSelectionThemeData base, Color accentColor, bool isDark) {
    return base.copyWith(
      cursorColor: accentColor,
      selectionColor: isDark ? kDarkGrey : kLightGrey,
      selectionHandleColor: accentColor,
    );
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
