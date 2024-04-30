import 'package:achivement_box/models/chartBar.dart';
import 'package:achivement_box/pages/homePage/Bodies/HomeBody/provider/levelProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db.dart';

class LevelBar extends StatelessWidget {
  const LevelBar(
      {super.key, required this.canChange, this.categoryName = 'main'});
  final bool canChange;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    canChange ? context.watch<LevelProvider>().x : null;
    Map<String, dynamic> r = getLevel(name: categoryName);
    final double percent = r['EarnedXp'] / r['MaxXp'];
    final int level = r['Level'];
    final int maxXp = r['MaxXp'];
    final int currentXp = r['EarnedXp'];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text("$currentXp / $maxXp",
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
      ),
      ChartBar(text: "level: $level", percent: percent)
    ]);
  }
}
