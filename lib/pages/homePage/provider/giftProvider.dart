import 'package:flutter/material.dart';

import '../../../db.dart';

class GiftProvider with ChangeNotifier {
  GiftProvider() {
    _Gifts = getGifts();
    _mostUsedGits = getMostUsedGifts(6);
  }
  newGift() {
    _Gifts = getGifts();
    notifyListeners();
  }

  giftPurchased() {
    _mostUsedGits = getMostUsedGifts(6);
    notifyListeners();
  }

  var _Gifts;
  get Gifts => _Gifts;
  var _mostUsedGits;
  get MostUsedGifts => _mostUsedGits;
}
