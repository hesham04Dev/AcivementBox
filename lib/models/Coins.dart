import 'package:achivement_box/db/sql.dart';
import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../output/generated/colors.dart';

class CoinsBar extends StatelessWidget {
  const CoinsBar({super.key});

  @override
  Widget build(BuildContext context) {
    int totalCoins = context.watch<CoinsProvider>().coins;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors[getAccentColorIndex()].withOpacity(0.3)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconImage(
            iconName: "coin-front.png",
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(addCommas(totalCoins),
              style: const TextStyle(
                  //color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ],
      ),
    );
  }

  String addCommas(int totalCoins) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return totalCoins.toString().replaceAllMapped(reg, mathFunc);
  }
}
