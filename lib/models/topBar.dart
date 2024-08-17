import 'package:flutter/material.dart';

import 'Coins.dart';
import 'levelBar.dart';

class TopBar extends StatelessWidget {
  final bool canLevelChange;
  const TopBar({super.key, required this.canLevelChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LevelBar(
            canChange: canLevelChange,
          ),
          const CoinsBar(),
        ],
      ),
    );
  }
}
