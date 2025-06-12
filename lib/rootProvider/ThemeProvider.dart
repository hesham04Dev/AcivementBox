import 'package:flutter/material.dart';

import '../db/db.dart';
import '../output/generated/colors.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    _accentColor = colors[db.sql.settings.getAccentColorIndex()];
    print("eee accent color: $_accentColor");
    _darkMode = db.sql.settings.getDarkMode();
    // _languageId = db.sql.settings.getLanguageId();
    
  }

  accentColorChanged(var color) {
    _accentColor = color;
    print("eee color changed");
    notifyListeners();
  }

  toggleMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  // languageChanged(int langId) {
  //   _languageId = langId;
  //   db.sql.settings.setLanguageId(langId);
  //   Translate.setLang(Translate.supportedLangs[langId]);
  //   notifyListeners();
  // }

  late Color _accentColor;
  get AccentColor => _accentColor;
  late bool _darkMode;
  get DarkMode => _darkMode;
  // late int _languageId;
  // int get LanguageId => _languageId;
  // String get Language => Translate.supportedLangs[_languageId];
  
}
