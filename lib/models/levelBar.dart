import 'package:achivement_box/models/chartBar.dart';
import 'package:flutter/material.dart';

class LevelBar extends StatelessWidget {
  final double percent = 0.1;
  final int level = 2;
  final int maxXp = 200;
  final int currentXp = 40;

  const LevelBar({super.key});

  @override
  Widget build(BuildContext context) {
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
