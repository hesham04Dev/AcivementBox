import 'package:flutter/cupertino.dart';

import 'tileWithCounter.dart';

class Gift extends TileWithCounter {
  void openEditPage(BuildContext context) {
    // TODO gift edit page note no remove on this
  }
  void clicked() {
    //TODO minus the price of the gift
    // show alert to undo
  }
  void undo() {
    // add the price to the coins
    // minus the totalTimes
  }

  Gift({
    required super.icon,
    required super.name,
    required super.price,
  });
}
