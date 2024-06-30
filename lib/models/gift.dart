import 'package:achivement_box/pages/EditPages/editGiftsPage.dart';
import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/sql.dart';
import '../rootProvider/giftProvider.dart';
import 'tileWithCounter.dart';

class Gift extends TileWithCounter {
  void openEditPage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return EditGiftsPage(
        gift: this,
      );
    }));
  }

  @override
  void clicked() {
    if (getCoins() >= super.price) {
      if (super.totalTimes == 1) {
        db.execute('''
      insert into logGift values('$formattedDate',${super.id},1)
      ''');
      } else {
        db.execute('''
      update  logGift set
      count = ${super.totalTimes}
      where DateOnly = '$formattedDate'
      and GiftId =${super.id}
      ''');
      }
      db.execute('''
    update  gift set NoOfUsed = NoOfUsed + 1 where
    Id = ${super.id};
    ''');

      context.read<GiftProvider>().giftUpdated();
      context.read<CoinsProvider>().removeCoins(super.price);

      toastTitle = "Gift purchased";
      undoToast.show(context);

      // show alert to undo
    } else {
      super.totalTimes--;
      CherryToast.warning(
        title: const Text("you don't have enough money"),
        animationType: AnimationType.fromTop,
        displayCloseButton: false,
      ).show(context);
    }
  }

  @override
  void undo() {
    if (super.totalTimes == 1) {
      db.execute('''
      delete from logGift where GiftId = ${super.id} and DateOnly = '$formattedDate'
      ''');
      super.totalTimes -= 1;
    } else {
      db.execute('''
      update  logGift set
      count = ${--super.totalTimes}
      where DateOnly = '$formattedDate'
      and GiftId =${super.id}
      ''');
    }
    db.execute('''
    update  gift set NoOfUsed = NoOfUsed - 1 where
    Id = ${super.id};
    ''');
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
}
