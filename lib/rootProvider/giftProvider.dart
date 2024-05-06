import 'package:flutter/material.dart';

import '../db/sql.dart';

class GiftProvider with ChangeNotifier {
  GiftProvider() {
    _Gifts = getGifts();
    _mostUsedGits = getMostUsedGifts();
  }
  newGift() {
    _Gifts = getGifts();
    notifyListeners();
  }

  giftPurchased() {
    _mostUsedGits = getMostUsedGifts();
    notifyListeners();
  }

  giftUpdated() {
    _mostUsedGits = getMostUsedGifts();
    _Gifts = getGifts();
    notifyListeners();
  }

  var _Gifts;
  get Gifts => _Gifts;
  var _mostUsedGits;
  get MostUsedGifts => _mostUsedGits;
}
