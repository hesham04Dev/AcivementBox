import 'package:flutter/cupertino.dart';

import '../../../../db/sql.dart';

class CoinsProvider with ChangeNotifier {
  CoinsProvider() {
    _coins = getCoins();
  }

  late int _coins;

  get coins => _coins;

  addCoins(int num) async {
    _coins += num;
    updateCoins(_coins);
    notifyListeners();
  }

  removeCoins(int num) async {
    _coins -= num;
    updateCoins(_coins);
    notifyListeners();
  }
}
