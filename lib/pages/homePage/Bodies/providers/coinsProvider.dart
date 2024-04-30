import 'package:achivement_box/db.dart';
import 'package:flutter/cupertino.dart';

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
