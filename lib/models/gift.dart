import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:achivement_box/pages/homePage/provider/giftProvider.dart';
import 'package:provider/provider.dart';

import '../db.dart';
import 'tileWithCounter.dart';

class Gift extends TileWithCounter {
  void openEditPage() {
    // TODO gift edit page note no remove on this
  }
  void clicked() {
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
    //TODO minus the price of the gift
    // show alert to undo
  }

  void undo() {
    // add the price to the coins
    // minus the totalTimes
  }

  Gift({
    required super.id,
    required super.totalTimes,
    required super.context,
    required super.icon,
    required super.name,
    required super.price,
  });
}
