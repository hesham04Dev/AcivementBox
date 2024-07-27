import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:achivement_box/pages/homePage/Bodies/providers/pageIndexProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'db/sql.dart';
import 'output/generated/colors.dart';
import 'pages/homePage/homePage.dart';
import 'rootProvider/ThemeProvider.dart';
import 'rootProvider/categoryProvider.dart';
import 'rootProvider/giftProvider.dart';
import 'rootProvider/habitProvider.dart';

const kWhite = Colors.white;
const kLightGrey = const Color(0xFFE8E8E8);
const kDarkGrey = const Color(0xFF202020);

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
            title: 'Flutter Demo',
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: _buildTheme(accentColor, isDarkMode),
            home: const HomePage(),
          );
        }));
  }

  ThemeData _buildTheme(Color accentColor, bool isDark) {
    final ThemeData base = isDark ? ThemeData.dark() : ThemeData.light();
    Color primaryColor = isDark ? kDarkGrey : kWhite;
    primaryColor = accentColor;
    print(primaryColor);
    final swatch = ColorScheme.fromSwatch(
        primarySwatch: colors[getAccentColorIndex()],
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
          shape: const CircleBorder(),
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
