import 'package:flutter/foundation.dart';

class LevelProvider with ChangeNotifier {
  xpIncreased() {
    notifyListeners();
    x++;
  }

  int x = 0;
}
