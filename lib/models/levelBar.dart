
import 'package:flutter/material.dart';
import "package:localization_lite/translate.dart";

import 'package:provider/provider.dart';

import 'chartBar.dart';
import '../db/db.dart';
import '../pages/homePage/Bodies/HomeBody/provider/levelProvider.dart';
class LevelBar extends StatelessWidget {
  const LevelBar(
      {super.key, required this.canChange, this.categoryName = 'main'});
  final bool canChange;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    canChange ? context.watch<LevelProvider>().x : null;
    Map<String, dynamic> r = db.sql.categories.getByName(name: categoryName);
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
      ChartBar(
        text: "${tr("level")}: $level",
        percent: percent,
        thickness: 15,
      )
    ]);
  }
}
