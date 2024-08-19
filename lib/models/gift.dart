import 'package:achivement_box/models/my_toast.dart';
import 'package:achivement_box/pages/EditPages/editGiftsPage.dart';
import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      if (super.totalTimes == 1) {
        db.sql.gifts.addToLog(super.id);
      } else {
        db.sql.gifts.updateLog(id: super.id, count: super.totalTimes);
      }
      db.sql.gifts.updateCount(id: super.id, sign: '+');
      context.read<GiftProvider>().giftUpdated();
      context.read<CoinsProvider>().removeCoins(super.price);

      toastTitle = "Gift purchased";
      undoToast.show(context);
    } else {
      super.totalTimes--;
      MyToast(
        title: const Text("you don't have enough money"),
        animationType: AnimationType.fromTop,
        displayCloseButton: false,
      ).show(context);
    }
  }

  @override
  void undo() {
    if (super.totalTimes == 1) {
      db.sql.gifts.deleteFromLog(id);
      super.totalTimes -= 1;
    } else {
      db.sql.gifts.updateLog(id: id, count: --super.totalTimes);
    }
    db.sql.gifts.updateCount(id: super.id, sign: '-');
    context.read<GiftProvider>().giftUpdated();
    context.read<CoinsProvider>().addCoins(super.price);
  }

  Gift({
    super.key,
    required super.id,
    required super.totalTimes,
    required super.context,
    required super.iconId,
    required super.name,
    required super.price,
  });
  static Gift giftBuilder(BuildContext context, Map<String, dynamic> gift) {
    return Gift(
        totalTimes: gift['NoOfUsed'],
        context: context,
        iconId: gift['IconId'],
        id: gift['Id'],
        name: gift['Name'],
        price: gift['Price']);
  }
}
