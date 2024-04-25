import 'package:flutter/cupertino.dart';

class CoinsProvider with ChangeNotifier {
  CoinsProvider() {
    //TODO get coins from db;
  }
  int _coins = 0;
  get coins => _coins;
  addCoins(int num) {
    _coins += num;
    notifyListeners();
    print("++$_coins");
  }

  removeCoins(int num) {
    _coins -= num;
    print("--$_coins");
    notifyListeners();
  }
}
