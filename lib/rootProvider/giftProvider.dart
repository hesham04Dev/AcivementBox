import 'package:flutter/material.dart';

import '../db/db.dart';

class GiftProvider with ChangeNotifier {
  GiftProvider() {
    _Gifts = db.sql.gifts.get();
    _mostUsedGits = db.sql.gifts.getMostUsed(_maxOfMostUsed);
  }

  newGift() {
    _Gifts = db.sql.gifts.get();
    notifyListeners();
  }

  giftPurchased() {
    _mostUsedGits = db.sql.gifts.getMostUsed(_maxOfMostUsed);
    notifyListeners();
  }

  giftUpdated() {
    _mostUsedGits = db.sql.gifts.getMostUsed(_maxOfMostUsed);
    _Gifts = db.sql.gifts.get();
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
