import 'package:flutter/foundation.dart';

class LevelProvider with ChangeNotifier {
  xpIncreased() {
    notifyListeners();
    x++; //TODO make it more clear
  }

  int x = 0;
}
