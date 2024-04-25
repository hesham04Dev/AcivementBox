import 'package:achivement_box/pages/homePage/Bodies/providers/coinsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinsBar extends StatelessWidget {
  const CoinsBar({super.key});

  @override
  Widget build(BuildContext context) {
    int totalCoins = context.watch<CoinsProvider>().coins;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.yellow[200]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/icons/coin128.png",
              color: Colors.orange, height: 15, width: 15),
          SizedBox(
            width: 5,
          ),
          Text(
              addCommas(
                  totalCoins), //TODO add comma after 3 number if there is more number
              style: TextStyle(
                  color: Colors.black54,
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
