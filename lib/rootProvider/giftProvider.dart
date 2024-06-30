import 'package:flutter/material.dart';

import '../db/sql.dart';

class GiftProvider with ChangeNotifier {
  GiftProvider() {
    _Gifts = getGifts();
    _mostUsedGits = getMostUsedGifts(_maxOfMostUsed);
  }

  newGift() {
    _Gifts = getGifts();
    notifyListeners();
  }

  giftPurchased() {
    _mostUsedGits = getMostUsedGifts(_maxOfMostUsed);
    notifyListeners();
  }

  giftUpdated() {
    _mostUsedGits = getMostUsedGifts(_maxOfMostUsed);
    _Gifts = getGifts();
    notifyListeners();
  }

  int _maxOfMostUsed = 3;
  set MaxOfMostUsed(maxOfMostUsed) {
    _maxOfMostUsed = maxOfMostUsed;
  }

  var _Gifts;
  get Gifts => _Gifts;
  var _mostUsedGits;
  get MostUsedGifts => _mostUsedGits;
}
