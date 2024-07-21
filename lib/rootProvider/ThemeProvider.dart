import 'package:flutter/material.dart';

import '../db/sql.dart';
import '../output/generated/colors.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    _accentColor = colors[getAccentColorIndex() ?? 0];
    _darkMode = getDarkMode();
  }

  accentColorChanged(var color) {
    _accentColor = color;
    notifyListeners();
  }

  toggleMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  late Color _accentColor;
  get AccentColor => _accentColor;
  late bool _darkMode;
  get DarkMode => _darkMode;
}
