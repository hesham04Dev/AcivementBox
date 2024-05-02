import 'package:flutter/material.dart';

import '../../../../../models/PrimaryContainer.dart';

class StatisticBar extends StatelessWidget {
  const StatisticBar(
      {super.key,
      required this.statisticName,
      required this.valueName,
      this.icon});
  final String statisticName;
  final String valueName;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
        padding: 14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$statisticName:\t $valueName"),
            icon ?? const SizedBox()
          ],
        ));
  }
}
