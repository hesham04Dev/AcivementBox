import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:localization_lite/translate.dart';
import 'package:provider/provider.dart';

import '../models/my_toast.dart';
import '../pages/EditPages/editGiftsPage.dart';
import '../pages/homePage/Bodies/providers/coinsProvider.dart';

import '../db/db.dart';
import '../rootProvider/giftProvider.dart';
import 'tileWithCounter.dart';

class Gift extends TileWithCounter {
  @override
  void openEditPage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return EditGiftsPage(
        gift: this,
      );
    }));
  }

  @override
  void clicked() {
    totalTimes++;
    if (db.sql.categories.getCoins() >= super.price) {
      if (db.sql.gifts.thisDayCount(giftId: super.id) == 0) {
        db.sql.gifts.addToLog(super.id);
      } else {
        db.sql.gifts.updateLogCount(id: super.id, sign: '+');
      }
      db.sql.gifts.updateCount(id: super.id, sign: '+');
      context.read<GiftProvider>().giftUpdated();
      context.read<CoinsProvider>().removeCoins(super.price);

      toastTitle = tr("giftPurchased");
      undoToast.show(context);
    } else {
      super.totalTimes--;
      MyToast(
        title:  Text(tr("dontHaveEnoughMoney")),
        animationType: AnimationType.fromTop,
        displayCloseButton: false,
      ).show(context);
    }
  }

  @override
  void undo() {
    if (db.sql.gifts.thisDayCount(giftId: super.id) == 1) {
      db.sql.gifts.deleteFromLog(id);
    } else {
      db.sql.gifts.updateLogCount(id: id, sign: '-');
    }
    super.totalTimes -= 1;
    db.sql.gifts.updateCount(id: super.id, sign: '-');
    context.read<GiftProvider>().giftUpdated();
    context.read<CoinsProvider>().addCoins(super.price);
  }

  Gift(
      {super.key,
      required super.id,
      required super.totalTimes,
      required super.context,
      required super.iconId,
      required super.name,
      required super.price,
      required super.isArchived});
  static Gift giftBuilder(BuildContext context, Map<String, dynamic> gift) {
    return Gift(
      totalTimes: gift['NoOfUsed'],
      context: context,
      iconId: gift['IconId'],
      id: gift['Id'],
      name: gift['Name'],
      price: gift['Price'],
      isArchived: gift['IsArchived'] == 1 ? true : false,
    );
  }
}
