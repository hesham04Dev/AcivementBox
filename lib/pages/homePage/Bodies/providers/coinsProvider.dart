import 'package:flutter/cupertino.dart';

import '../../../../db/db.dart';

class CoinsProvider with ChangeNotifier {
  CoinsProvider() {
    _coins = db.sql.categories.getCoins();
  }

  late int _coins;

  get coins => _coins;

  addCoins(int num) async {
    _coins += num;
    db.sql.categories.updateCoins(_coins);
    notifyListeners();
  }

  removeCoins(int num) async {
    _coins -= num;
    db.sql.categories.updateCoins(_coins);
    notifyListeners();
  }
}
