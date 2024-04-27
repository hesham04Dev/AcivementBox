import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:provider/provider.dart';

import 'tileWithCounter.dart';

class Gift extends TileWithCounter {
  void openEditPage() {
    // TODO gift edit page note no remove on this
  }
  void clicked() {
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
